//
//  RecipeSearch.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation

class SettingService {
    private struct Keys {
        static let ingredients = "ingredients"
    }
    static var ingredients: [String] {
        get {
            UserDefaults.standard.array(forKey: Keys.ingredients) as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.ingredients)
        }
    }
}



