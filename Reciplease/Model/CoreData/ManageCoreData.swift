//
//  ManageCoreData.swift
//  Reciplease
//
//  Created by Léa Kieffer on 05/12/2021.
//

import Foundation
import CoreData
import UIKit

class ManageCoreData {

    let persistentContainer: NSPersistentContainer!
    var delegateCoreData: ManageCoreDataDelegate?
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
   
    convenience init() {
        //Use the default container for production environment
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { fatalError("no coreData") }
    
        self.init(container: appDelegate.persistentContainer)
    }
    
    var all: [RecipleaseCoreData] {
        let request: NSFetchRequest<RecipleaseCoreData> = RecipleaseCoreData.fetchRequest()
        guard let recipes = try? self.persistentContainer.viewContext.fetch(request) else { return [] }
        return recipes
    }

    func searchRecord(url: String) -> Bool {
        let request: NSFetchRequest<RecipleaseCoreData> = RecipleaseCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        guard let resultRequest = try? self.persistentContainer.viewContext.fetch(request) else { return false }
        if resultRequest.first != nil {
            return true
        } else {
            return false
            
        }
    }

    func addRecipe(recipe: RecipePlease) {
        let recipeSave = RecipleaseCoreData(context: self.persistentContainer.viewContext)
        saveRecipe(recipe: recipe, recipeData: recipeSave)
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            delegateCoreData?.alertWithCoreData(error: .errorAddFavorite)
        }
    }

    func saveRecipe(recipe: RecipePlease, recipeData: RecipleaseCoreData) {
        let recipeSave = recipeData
        recipeSave.image = recipe.image
        recipeSave.ingredientLines = recipe.ingredientLines
        recipeSave.url = recipe.url
        recipeSave.yield = Int16(recipe.yield)
        recipeSave.totalTime = Int16(recipe.totalTime)
        recipeSave.label = recipe.label
    }
    
    func deleteRecipe(recipe: RecipleaseCoreData) {
        self.persistentContainer.viewContext.delete(recipe)
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            delegateCoreData?.alertWithCoreData(error: .errorDeleteFavorite)
        }
    }
}

protocol ManageCoreDataDelegate {
    func alertWithCoreData(error: ErrorMessage)
}

