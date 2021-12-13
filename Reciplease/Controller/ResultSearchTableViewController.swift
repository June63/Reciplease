//
//  ResultSearchTableViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import UIKit

class ResultSearchTableViewController: UITableViewController {
    //for loadingView of tableView
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    // scrollview
    var lastContentOffset: CGFloat = 0
    var recipeSearch = RecipeSearch(recipeServiceSession: RecipeService(recipeSession: RecipeSession()))

    @IBOutlet weak var tableViewList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeSearch.delegateRecipe = self
        DispatchQueue.main.async {
        self.recipeSearch.executeRequest(ingredient: self.recipeSearch.ingredientList)
        }
        tableViewList.setLoadingScreen(loadingView: loadingView, spinner: spinner, loadingLabel: loadingLabel)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeSearch.listRecipe.count
    }

    private func createCell(cell: CellCustom, index: Int) {
        let listRecipe = recipeSearch.listRecipe
        cell.labelNameRecipe.text = "\(listRecipe[index].label)\n\(listRecipe[index].ingredientLines.createString())"
        cell.detailView.instantiate(labelLikeText: String(listRecipe[index].yield), labelTimeRecipeText: listRecipe[index].totalTime.hour())
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCustom", for: indexPath) as! CellCustom
        createCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeSearch.recipeDetail = recipeSearch.listRecipe[indexPath.row]
        performSegue(withIdentifier: Constant.segueDetailRecipe, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let middle = recipeSearch.listRecipe.count / 2
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - middle {
            scroll(tableViewList)
        }
    }
    //ScrollView
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }

    private func scroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            if recipeSearch.listRecipe.count == 100 {
                return presentAlert(error: ErrorMessage.limitResult)
            }
            
            recipeSearch.prepareForRequestInTableView()
            /*guard let number = Int(Constant.numberResult) else { return }
            var numberNext = number
            numberNext += 15
            if numberNext >= 100 {
                numberNext = 100
            }
            Constant.numberResult = String(numberNext)

            guard let from = Int(Constant.from) else { return }
            let fromNext = from + 15
            Constant.from = String(fromNext)*/
            recipeSearch.executeRequest(ingredient: self.recipeSearch.ingredientList)
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueDetailRecipe {
            if let vcDestination = segue.destination as? DetailRecipeViewController {
                vcDestination.recipeDetail.recipeDetail = recipeSearch.recipeDetail
            }
        }
    }

}
