//
//  DatabaseService.swift
//  Reciplease
//
//  Created by Léa Kieffer on 20/12/2021.
//

import Foundation
import CoreData

class DatabaseService {
    
    // MARK: - Singleton
    static let shared = DatabaseService()

    // MARK: - Context Core Data
    private let persistentContainer: NSPersistentContainer
    private let viewContext: NSManagedObjectContext
    
    init(persistentContainer: NSPersistentContainer = AppDelegate.persistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        self.viewContext = persistentContainer.viewContext
    }
    
    // MARK: - private function Core Data
    func save(recipe: Recipe) throws {
        let recipeEntity = RecipeEntity(context: viewContext)
        recipeEntity.title = recipe.title
        recipeEntity.imageUrl = recipe.imageUrl
        recipeEntity.url = recipe.url
        recipeEntity.portions = recipe.portions
        recipeEntity.totalTime = recipe.totalTime
        recipeEntity.ingredients = try? JSONEncoder().encode(recipe.ingredients)
        do {
            try viewContext.save()
            print("Recipe \(recipe.title) added to CoreData")
        } catch let error {
            throw error
        }
    }
    
    func loadRecipes() throws -> [Recipe] {
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let recipeEntities: [RecipeEntity]
        do {
            recipeEntities = try viewContext.fetch(fetchRequest)
        } catch let error {
            throw error
        }
        return recipeEntities.map { Recipe(from: $0) }
    }
    
    func delete(recipe: Recipe) throws {
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let titlePredicate = NSPredicate(format: "title == %@", recipe.title)
        let urlPredicate = NSPredicate(format: "url == %@", recipe.url)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [titlePredicate, urlPredicate])
        
        let managedObject = try viewContext.fetch(fetchRequest)
        managedObject.forEach { (entity) in
            viewContext.delete(entity)
        }
        do {
            try viewContext.save()
            print("Recipe \(recipe.title) deleted")
        } catch let error {
            throw error
        }
    }
}
