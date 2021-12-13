//
//  ViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var recipe = Recipe()
    var ingredientList = String()
    @IBOutlet weak var recipleaseView: RecipleaseView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipleaseView.delegateRecipleaseView = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipe.listRecipe = [RecipePlease]()
        //recipe.ingredientList = [String]()
        recipleaseView.ingredientTableList.reloadData()
    }
    
    func initSwipeGesture(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeForEditing(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueResult {
            if let vcDestination = segue.destination as? ResultSearchTableViewController {
                let ingredient = recipe.createListIngredientForRequest()
                guard let ingredientListIsOk = ingredient else { return }
                vcDestination.recipeSearch.ingredientList = ingredientListIsOk
            }
        }
    }
}
