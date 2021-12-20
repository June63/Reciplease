//
//  ResultRequest.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation

struct ResultRequest: Decodable {
    let count: Int
    let hits: [Hit]
    struct Hit: Decodable {
        let recipe: RecipeResult
        struct RecipeResult: Decodable {
            let uri: String
            let label: String
            let calories: Double
            let ingredientLines: [String]
            let totalTime: Int
            let image: String
            let url: String
        }
    }
}

