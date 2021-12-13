//
//  Constant.swift
//  Reciplease
//
//  Created by Léa Kieffer on 05/12/2021.
//


import Foundation

class Constant {
    static let baseURL = "https://api.edamam.com"
    static let appId = "07a3e0af"
    static let appKey = "e34a263a1d35723913661e204160541e"
    static var numberResult = "15"
    static var from = "0"
    static var ingredient = String()
    //Segue
    static let segueResult = "segueResult"
    static let segueDetailRecipe = "detailRecipe"
    static let segueDetailRecipeCoreData = "detailRecipeCoreData"
    //request IMage
    static var urlImage = String()
    // message tableview empty
    static var messageFavorisTableView = "No favorites yet. Just tap the star to add a favorite recipe. To remove it from the list of favorites, simply make a left swipe on the recipe."
    static var messageSearchTableView = "Oops! No recipes found sorry."
}
