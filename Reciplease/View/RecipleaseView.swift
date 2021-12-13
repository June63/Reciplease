//
//  RecipleaseView.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import UIKit

class RecipleaseView: UIView {
    
    var delegateRecipleaseView: WhenButtonIsClicked?
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var ingredientTableList: UITableView!
    @IBOutlet weak var searchButtonRecipe: UIButton!
    
    
    var ingredientTextFieldIsEmpty: Bool {
        return ingredientTextField.text?.isEmpty == true
    }
    
    func addIngredientInTableView() {
        if let text = ingredientTextField.text {
            delegateRecipleaseView?.buttonAddIsClicked(ingredient: text)
            ingredientTextField.text = ""
        }
    }
    
    @IBAction func addIngredient(_ sender: UIButton) {
        switch sender {
        case addIngredientButton:
            ingredientTextFieldIsEmpty ? delegateRecipleaseView?.alertButtonAddIngredient() : addIngredientInTableView()
        case clearButton:
            delegateRecipleaseView?.buttonClearIsClicked()
        case searchButtonRecipe:
            delegateRecipleaseView?.buttonSearchRecipe()
        default: break
        }
    }

}

protocol WhenButtonIsClicked {
    func buttonAddIsClicked(ingredient: String)
    func buttonClearIsClicked()
    func buttonSearchRecipe()
    func alertButtonAddIngredient()
}

