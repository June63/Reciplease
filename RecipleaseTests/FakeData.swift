//
//  FakeData.swift
//  RecipleaseTests
//
//  Created by Léa Kieffer on 02/12/2021.
//

@testable import Reciplease
import Foundation

class FakeData {
    
    static var recipeData: Data {
        let bundle = Bundle(for: self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        return try! Data(contentsOf: url!)
    }
      
    private static var results: Reciplease {
        return try! JSONDecoder().decode(Reciplease.self, from: recipeData)
    }
    
    static var recipes: [Recipe] {
        return results.recipes
    }
    
    static let incorrectData = "incorrect data".data(using: .utf8)!
    
    enum FakeError: Error, Equatable {
        case apiError
    }
}
