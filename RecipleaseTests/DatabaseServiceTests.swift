//
//  DatabaseServiceTests.swift
//  RecipleaseTests
//
//  Created by Léa Kieffer on 15/12/2021.
//

@testable import Reciplease
import XCTest
import CoreData

class DatabaseServiceTests: XCTestCase {

    private var loadedRecipes: [Recipe] = []
    
    private static let managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])
        return managedObjectModel!
    }()

    let databaseService: DatabaseService = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.shouldAddStoreAsynchronously = false
        
        let container = NSPersistentContainer(name: "Reciplease_Project", managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { description, error in
            precondition(description.type == NSInMemoryStoreType, "Precondition failed, store description is not of type in memory")
            if let error = error { fatalError("Error creating persistent coordinator \(error))")
            }
        }
        return DatabaseService(persistentContainer: container)
    }()
    
    override func tearDownWithError() throws {
        loadedRecipes = []
    }
    
    func testRecipeSaveAndLoad() {
        XCTAssertEqual(loadedRecipes.count, 0)
        
        let recipes = FakeData.recipes
        
        recipes.forEach { recipe in
            do {
                try databaseService.save(recipe: recipe)
            } catch {
                XCTFail("error saving recipe \(error.localizedDescription)")
            }
        }
        
        do {
            loadedRecipes = try databaseService.loadRecipes()
        } catch {
            XCTFail("error loading recipes \(error.localizedDescription)")
        }
        
        XCTAssertEqual(loadedRecipes.count, 10)
    }
    
    func testRecipeDeleted() {
        
        XCTAssertEqual(loadedRecipes.count, 0)
        
        let recipes = FakeData.recipes
        
        recipes.forEach { recipe in
            do {
                try databaseService.save(recipe: recipe)
            } catch {
                XCTFail("error saving recipe \(error.localizedDescription)")
            }
        }
        
        let randomIndex = Int.random(in:0..<recipes.count)
        let recipeToDelete = recipes[randomIndex]
        
        do {
            try databaseService.delete(recipe: recipeToDelete)
        } catch {
            XCTFail("error deleting recipe \(error.localizedDescription)")
        }
        
        do {
            loadedRecipes = try databaseService.loadRecipes()
        } catch {
            XCTFail("error loading recipes \(error.localizedDescription)")
        }
        
        XCTAssertEqual(loadedRecipes.count, 9)
        
        let deletedRecipes = recipes.filter { !loadedRecipes.contains($0) }
        XCTAssertEqual(deletedRecipes.count, 1)
        XCTAssertEqual(deletedRecipes[0], recipeToDelete)
    }
}
