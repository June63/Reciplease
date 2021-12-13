//
//  RecognizerVC.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import UIKit
import AVFoundation
import Vision

class RecognizerVC: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var recognizerView: UIView!
    @IBOutlet weak var ui_Label: UILabel!
    @IBOutlet weak var recogTableView: UITableView!
    @IBOutlet weak var newIngredientButtonOutlet: UIButton!
    @IBOutlet weak var finishButtonOutlet: UIButton!
    //MARK: - Propertie
    let captureSession = AVCaptureSession()
    var userTabIngredientRecognizer = [String]()
    var ingredientRecognized = ""
    
    lazy var imageRecognizerRequest: VNRequest = { // propriété calculé de type lazy, chargée uniquement lorsque la variable est appelée et réutilisée par la suite sans être de nouveau chargée
        guard let model = try? VNCoreMLModel(for: FruitAndVegetables().model) else {return VNRequest()}// on charge le fichier datamodel
        let request = VNCoreMLRequest(model: model, completionHandler: self.imageRecognizerHandler) // il charge le model et lance le completion handler de la fonction ci dessous
            return request
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        designItemBarNavigation()
        designButton()
        
        recogTableView.dataSource = self
        recogTableView.backgroundColor = UIColor.clear
        recognizerView.backgroundColor = UIColor.clear
        recognizeSession()
    }
    
   //MARK: - Action
    @IBAction func addIngredientButtonRecognizer(_ sender: UIButton) {
        addIngredientRecognized()
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func terminateIngredientListRecognizer(_ sender: UIButton) {
        captureSession.stopRunning()
        performSegue(withIdentifier: "segueAddIngredientRecognizer", sender: nil)
    }
    
    //MARK: - Helpers
    private func addIngredientRecognized() {
        userTabIngredientRecognizer.append(ingredientRecognized)
        recogTableView.reloadData()
    }
    ///we check the state of the capture session
    private func recognizeSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        } else {
            if captureSession.inputs.count == 0 {
                configureCaptureSession()
            }
            // 4 démarrer la session
            captureSession.startRunning()
        }
    }
    
    
    //MARK: - Setup View
    private func designItemBarNavigation() {
        self.navigationItem.title = "Recognition"
        UINavigationBar.appearance().tintColor = .white
    }
    private func designButton() {
        newIngredientButtonOutlet.layer.cornerRadius = 5
        finishButtonOutlet.layer.cornerRadius = 5
        ui_Label.layer.cornerRadius = 5
        ui_Label.text = "wait for research..."
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddIngredientRecognizer" {
            let navVC = segue.destination as! UINavigationController
            let successVC = navVC.viewControllers.first as! ViewController
            for ingredient in userTabIngredientRecognizer {
                successVC.recipe.ingredientList.append(ingredient)
            }
        }
    }
}

extension RecognizerVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    ///func for configure capture session
    func configureCaptureSession() {
        // 1 - configurer les entrées, le flux entrant
        if let camera = AVCaptureDevice.default(for: AVMediaType.video), // start camera, continue si la caméra a été trouvée.
            let cameraFeed = try? AVCaptureDeviceInput(device: camera) { // flux d'entrée
            captureSession.addInput(cameraFeed) // je capture le flux d'entrée et je l'envoie à la session
            // ajouter une autorisation
            // 2 - configurer les sorties
            let outputFeed = AVCaptureVideoDataOutput()
            outputFeed.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)) // dispatch queue: user initiated lance un dispatch queue à l'uinitiative de l'utilisateur
            captureSession.addOutput(outputFeed)
            // 3 - configurer l'aperçu
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = recognizerView.bounds
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            recognizerView.layer.addSublayer(previewLayer)
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) { // sample buffer contient les datas.
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation.up, options: [:])
        do {
            try imageRequestHandler.perform([imageRecognizerRequest])
        } catch {
            print(error)
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) { // quand le processeur est surchargé. Il perd des frames. Permet de prévenir l'utilisateur qu'il y a un ralentissement
    }
    
    func imageRecognizerHandler(request:VNRequest, error: Error?) {
        // si je n'ai pas les bonnes observations au bon format et si il n'y a pas un élément à l'intérieur(best  guesss.first)
        guard let observations = request.results as? [VNClassificationObservation], let bestGuess = observations.first else {return}
        // Vision utilise le thread sur lequel il est programmé
        DispatchQueue.main.async { // le code utilisé ici ne sera fait que sur le thread graphique pendant que la capture tourne en tache de fond
            if bestGuess.confidence > 0.90 && bestGuess.identifier != "" {
                self.ui_Label.text = bestGuess.identifier
                self.ingredientRecognized = bestGuess.identifier
            } else {
                self.ui_Label.text = "wait for research..."
            }
        }
    }
}

extension RecognizerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTabIngredientRecognizer.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recogCell", for: indexPath)
        let ingredients = userTabIngredientRecognizer.map({$0})
        let ingredientsList = ingredients[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 17, weight: .heavy)
        cell.textLabel?.text = ingredientsList
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        userTabIngredientRecognizer.remove(at: indexPath.row)
        recogTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
        recogTableView.reloadData()
    }
}
