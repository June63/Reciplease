//
//  ManageCoreDataTest.swift
//  RecipleaseTests
//
//  Created by Léa Kieffer on 15/12/2021.
//

import XCTest
import CoreData

@testable import Reciplease

class ManageCoreDataTest: XCTestCase {
    
    var manageCoreData: ManageCoreData!

    override func setUp() {
        super.setUp()
        manageCoreData = ManageCoreData(container: mockPersistantContainer)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func createRecipe(label: String, image: String, url: String, yield: Int, ingredientLines: [String], totalTime: Int) -> RecipePlease {
        let recipe = RecipePlease(label: label, image: image, url: url, yield: yield, ingredientLines: ingredientLines, totalTime: totalTime)
        return recipe
    }

    func testSaveRecipeInRecipeCoreData() {
        let recipe1 = createRecipe(label: "chiken vesuo", image: "abc", url: "abc", yield: 10, ingredientLines: ["chicken","paprika"], totalTime: 10)
        let recipeCoreData = RecipleaseCoreData(context: manageCoreData!.persistentContainer.viewContext)
        manageCoreData.saveRecipe(recipe: recipe1, recipeData: recipeCoreData)
        
        
    }
    func testAddRecipeInCoreData() {
        let recipe1 = createRecipe(label: "chiken vesuo", image: "abc", url: "abc", yield: 10, ingredientLines: ["chicken","paprika"], totalTime: 10)
        
        manageCoreData.addRecipe(recipe: recipe1)
        
        XCTAssertEqual(manageCoreData.all.count, 1)
        
    }
    func testSearchRecordKo() {
        
        let result = manageCoreData.searchRecord(url: "abc")
        
        XCTAssertEqual(result, false)
        XCTAssertNotEqual(result, true)
    }
    func testSearchRecordOk() {
        let recipe1 = createRecipe(label: "chiken vesuo", image: "abc", url: "abc", yield: 10, ingredientLines: ["chicken","paprika"], totalTime: 10)
        manageCoreData.addRecipe(recipe: recipe1)
        
        let result = manageCoreData.searchRecord(url: "abc")
        let result2 = manageCoreData.searchRecord(url: "aze")
        
        XCTAssertEqual(result, true)
        XCTAssertEqual(result2, false)
        XCTAssertNotEqual(result, false)
        XCTAssertNotEqual(result2, true)
    }
    
    func testDeleteObject() {
        let recipe1 = createRecipe(label: "chiken vesuo", image: "abc", url: "abc", yield: 10, ingredientLines: ["chicken","paprika"], totalTime: 10)
        manageCoreData.addRecipe(recipe: recipe1)
        let recipeCoreData = manageCoreData.all[0]
        
        manageCoreData.deleteRecipe(recipe: recipeCoreData)
        
        XCTAssertEqual(manageCoreData.all.count, 0)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Reciplease")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

}

