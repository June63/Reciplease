//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Léa Kieffer on 15/12/2021.
//

@testable import Reciplease
import Foundation

class FakeResponseData {
    
    static let incorrectData = "incorrect data".data(using: .utf8)!
    
    static var recipeData: Data {
        let bundle = Bundle(for: self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        return try! Data(contentsOf: url!)
    }
      
    static var results: Reciplease {
        return try! JSONDecoder().decode(Reciplease.self, from: recipeData)
    }
    
    static var recipes: [Recipe] {
        return results.recipes
    }
}
