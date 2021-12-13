//
//  ExtensionViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  recipe.ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = recipe.ingredientList[indexPath.row]
        return cell
    }
    
    @objc func swipeForEditing(_ sender: UISwipeGestureRecognizer?) {
        recipleaseView.ingredientTableList.isEditing ? (recipleaseView.ingredientTableList.isEditing = false) : (recipleaseView.ingredientTableList.isEditing = true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            recipe.ingredientList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        recipleaseView.ingredientTextField.resignFirstResponder()
        return true
    }
}

extension ViewController: WhenButtonIsClicked {

    private func clearIngredientInList() {
        recipe.ingredientList = [String]()
        recipleaseView.ingredientTableList.reloadData()
    }

    func buttonClearIsClicked() {
        recipe.ingredientListIsEmpty ? presentAlert(error: .errorIngredientneeded) : clearIngredientInList()
    }
    
    private func goRequest() {
        let ingredient = recipe.createListIngredientForRequest()
        guard let ingredientRequest = ingredient else {
            return
        }
        ingredientList = ingredientRequest
        performSegue(withIdentifier: Constant.segueResult, sender: nil)
    }
    
    func buttonSearchRecipe() {
        recipe.ingredientListIsEmpty ? presentAlert(error: .errorIngredientneeded) : goRequest()
    }
    
    func buttonAddIsClicked(ingredient: String) {
        recipe.reorderIngredientInArray(ingredient: ingredient)
        recipleaseView.ingredientTableList.reloadData()
    }
    
    func alertButtonAddIngredient() {
        presentAlert(error: .errorIngredientneeded)
    }
}

