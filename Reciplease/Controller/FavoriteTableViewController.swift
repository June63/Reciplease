//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController {
    
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    let searchController = UISearchController(searchResultsController: nil)

    var manageCoreData = ManageCoreData()
    var recipeFavorite = RecipeFavorite()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageCoreData.delegateCoreData = self
        initSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeFavorite.recipeArray = manageCoreData.all
        favorisOrNot()
        tableView.reloadData()
    }
    // MARK: - gesture
    private func initSwipeGesture(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeForEditing(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    // MARK: - Display LabelMessageFavoris
    private func favorisOrNot() {
        messageFavoris() ? tableView.setEmptyMessage(Constant.messageFavorisTableView) : tableView.restore()
    }
    
    private func messageFavoris() -> Bool {
        if recipeFavorite.recipeArray.isEmpty == true {
            return true
        } else {
            return false
        }
    }
    // MARK: - func Search Controller
    private func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Recipe"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.white
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        recipeFavorite.recipeSearch = recipeFavorite.recipeArray.filter({( recipe : RecipleaseCoreData) -> Bool in
            guard let name = recipe.label else {
                return false
            }
            return name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering() ? (recipeFavorite.dataSource = recipeFavorite.recipeSearch) : (recipeFavorite.dataSource = recipeFavorite.recipeArray)
        return recipeFavorite.dataSource.count
    }
    
    private func createCell(cell: CellCustom, index: Int) {
        guard let label = recipeFavorite.dataSource[index].label else {
            return
        }
        guard let ingredient = recipeFavorite.dataSource[index].ingredientLines else { return }
        cell.labelNameRecipe.text = "\(label)\n\(ingredient.createString())"
        let totalTime = Int(recipeFavorite.dataSource[index].totalTime)
        cell.detailView.instantiate(labelLikeText: String(recipeFavorite.dataSource[index].yield), labelTimeRecipeText: String(totalTime.hour()))
        guard let imageStringUrl = recipeFavorite.dataSource[index].image else { return }
        cell.imageRecipe.downloaded(from: imageStringUrl)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCustom", for: indexPath) as! CellCustom
        createCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeFavorite.recipeDetailCoreData = recipeFavorite.dataSource[indexPath.row]
        performSegue(withIdentifier: Constant.segueDetailRecipeCoreData, sender: nil)
    }
    
    @objc func swipeForEditing(_ sender: UISwipeGestureRecognizer?) {
        if tableView.isEditing == true {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let objectDelete = recipeFavorite.recipeArray[indexPath.row]
            manageCoreData.deleteRecipe(recipe: objectDelete)
            recipeFavorite.recipeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            favorisOrNot()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueDetailRecipeCoreData {
            if let vcDestination = segue.destination as? DetailRecipeViewController {
                vcDestination.recipeDetail.recipeDetailCoreData = recipeFavorite.recipeDetailCoreData
            }
        }
    }
}
