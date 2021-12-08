//
//  Constants.swift
//  Reciplease
//
//  Created by Léa Kieffer on 05/12/2021.
//

import Foundation

struct Constants {
    static let apiAppId = "07a3e0af"
    static let apiKey = "e34a263a1d35723913661e204160541e"

    
    // MARK: - CORE DATA
    static let modelName = "Reciplease"

    // MARK: - SEGUES
    static let recipeSelectedSegue = "recipeSelected"

    // MARK: - COURSES
    private static let mainDishes = Course(name: "Main Dishes", color: #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))
    private static let desserts = Course(name: "Desserts", color: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))
    private static let sideDishes = Course(name: "Side Dishes", color: #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
    private static let appetizers = Course(name: "Appetizers", color: #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))
    private static let salads = Course(name: "Salads", color: #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1))
    private static let breakfastAndBrunch = Course(name: "Breakfast and Brunch", color: #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1))
    private static let breads = Course(name: "Breads", color: #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1))
    private static let soups = Course(name: "Soups", color: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
    private static let beverages = Course(name: "Beverages", color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
    private static let condimentsAndSauces = Course(name: "Condiments and Sauces", color: #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1))
    private static let cocktails = Course(name: "Cocktails", color: #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1))
    private static let snacks = Course(name: "Snacks", color: #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1))
    private static let lunch = Course(name: "Lunch", color: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))

    static let courses = [appetizers, beverages, breads, breakfastAndBrunch, cocktails, condimentsAndSauces, desserts, lunch, mainDishes, salads, sideDishes, snacks, soups]
}

