//
//  CurrentRecipe.swift
//  Reciplease
//
//  Created by Léa Kieffer on 05/12/2021.
//

import Foundation
import CoreData

struct SearchRecipe: Decodable {
    let hits: [Hit]
    let count: Int
}

struct Hit: Decodable {
    let recipe: RecipePlease
}

struct RecipePlease: Decodable {
    var label: String
    var image: String
    var url: String
    var yield: Int
    var ingredientLines: [String]
    var totalTime: Int
}
