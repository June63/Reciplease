//
//  Favorite.swift
//  Reciplease
//
//  Created by Léa Kieffer on 08/12/2021.
//

import Foundation
import CoreData

class Favorite: NSManagedObject {

    static var all: [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        guard let favorites = try? CoreDataStack(modelName: Constants.modelName).viewContext.fetch(request) else {
            return []
        }
        return favorites
    }

    static var recipes: [Recipe] {
        var recipes = [Recipe]()
        for favorite in all {
            if let id = favorite.id, let name = favorite.name, let imageSmall = favorite.imageSmall, let ingredients = favorite.ingredients, let course = favorite.course {
                let recipe = Recipe(id: id, name: name, imageSmall: imageSmall, rating: favorite.rating, ingredients: ingredients, totalTimeInSeconds : favorite.totalTimeInSeconds, course: course)
                recipes.append(recipe)
            }
        }
        return recipes
    }
}


