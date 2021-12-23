//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 23/12/2021.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    
    var recipe: Recipe?

    @IBOutlet weak var recipeImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var getDirectonButton: UIButton!
   
    private let recipeInfoView = RecipeInfoView()
    
    private var isFavorite = false
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFavorite = recipeIsInFavorites()
        setupDelegates()
        setupView()
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupView() {
        title = "Reciplease"
        getDirectonButton.layer.cornerRadius = 10
        titleLabel.text = recipe?.title
        setupRecipeInfoView()
        setupFavoriteButton()
        setupImage()
        tableView.reloadData()
    }

    private func setupRecipeInfoView() {
        recipeInfoView.duration = recipe?.totalTime
        recipeInfoView.portions = recipe?.portions
        recipeInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeInfoView)
        
        NSLayoutConstraint.activate([
            recipeInfoView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: recipeInfoView.trailingAnchor, multiplier: 1.0)
        ])
    }
    
    // MARK: - setupImage
    
    private func setupImage() {
        guard let recipeImageURLString = recipe?.imageUrl,
            let recipeImageURL = URL(string: recipeImageURLString)  else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: recipeImageURL) {
                let image = UIImage.init(data: data)
                DispatchQueue.main.async {
                    self?.recipeImageView.image = image
                }
            }
        }
    }
    
    // MARK: Favorite methods
    
    private func setupFavoriteButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: isFavorite ? "star.fill" : "star"),
            style: .plain,
            target: self,
            action: #selector(favoriteTapped))
    }
    
    private func recipeIsInFavorites() -> Bool {
        guard let recipes = try? DatabaseService.shared.loadRecipes(),
            let recipe = recipe else { return false }
        
        return recipes.contains(recipe)
    }
    
    private func addToFavorites() throws {
        guard let recipe = recipe else { return }
        do { try DatabaseService.shared.save(recipe: recipe) }
        catch let error { throw error }
    }
    
    private func deleteFromFavorites() throws {
        guard let recipe = recipe else { return  }
        do { try DatabaseService.shared.delete(recipe: recipe) }
        catch let error { throw error }
    }
    
    // MARK: Action methods
    
    @objc
    private func favoriteTapped() {
        if isFavorite {
            do {
                try deleteFromFavorites()
            } catch let error {
                print(error.localizedDescription)
                displayAlert(title: "Database error", message: "Cannot delete recipe")
            }
        } else {
            do {
                try addToFavorites()
            } catch let error {
                print(error.localizedDescription)
                displayAlert(title: "Database error", message: "Unable to add recipe")
            }
        }
        isFavorite.toggle()
        setupFavoriteButton()
    }
    
    @IBAction func getDirection(sender: UIButton) {
        guard let recipeURLString = recipe?.url,
            let recipeURL = URL(string: recipeURLString) else {
                return
        }
        let safariVC = SFSafariViewController(url: recipeURL)
        present(safariVC, animated: true, completion: nil)
    }
}

// MARK: - Table view data source

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.ingredientsCellId, for: indexPath)
        cell.textLabel?.text = "- \(recipe?.ingredients[indexPath.row] ?? "")"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
