//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import UIKit
import SafariServices
import CoreData

class DetailRecipeViewController: UIViewController {
    
    @IBOutlet weak var detailViewRecipe: DetailRecipeView!
    var manageCoreData = ManageCoreData()
    var recipeDetail = RecipeDetail()

    override func viewDidLoad() {
        super.viewDidLoad()
        manageCoreData.delegateCoreData = self
        detailViewRecipe.delegateDetailRecipe = self
        recipeDetail.recipeArrayCoreData = manageCoreData.all
        initViewFinal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initViewFinal()
    }
    // - MARK: init view
    private func initViewFinal() {
        guard recipeDetail.recipeDetail != nil else {
            guard let url = recipeDetail.recipeDetailCoreData.url else { return }
            initView(url: url)
            return
        }
        initView(url: recipeDetail.recipeDetail.url)
    }

    private func favoris() {
        detailViewRecipe.initView(recipe: recipeDetail)
        detailViewRecipe.favoriteButton.setImage(UIImage(named: "stargreen."), for: .normal)
    }

    private func initView(url:String) {
        manageCoreData.searchRecord(url: url) ? favoris() : detailViewRecipe.initView(recipe: recipeDetail)
    }
 
}
