//
//  RecipeSearchTestCase.swift
//  RecipleaseTests
//
//  Created by Léa Kieffer on 15/12/2021.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipeSearchTestCase: XCTestCase {
    
    var recipeSearch: RecipeSearch!

    override func setUp() {
        super.setUp()
        recipeSearch = RecipeSearch(recipeServiceSession: RecipeService(recipeSession: RecipeSession()))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    let ingredient = "bannane,chicken,lemon,paprika"
    
    let ingredientList = ["bannane","chicken","lemon","paprika"]
    
    private func createReciplease(label: String,image: String, url: String, yield:Int,ingredientLines: [String],totalTime: Int) -> RecipePlease {
        let recipe = RecipePlease(label: label, image: image, url: url, yield: yield, ingredientLines: ingredientLines, totalTime: totalTime)
        return recipe
    }
    private func createHit() -> [Hit] {
        var hit = [Hit]()
        let hit1 = Hit(recipe: createReciplease(label: "chicken Visuo", image: "aaaa", url: "bbb", yield: 10, ingredientLines: ["chicken"], totalTime: 50))
        hit.append(hit1)
        let hit2 = Hit(recipe: createReciplease(label: "chicken Lemon", image: "aaaa", url: "bbb", yield: 10, ingredientLines: ["chicken"], totalTime: 50))
        hit.append(hit2)
        let hit3 = Hit(recipe: createReciplease(label: "chicken Paprika", image: "aaaa", url: "bbb", yield: 10, ingredientLines: ["chicken"], totalTime: 50))
        hit.append(hit3)
        return hit
    }
    private func createSearchRecipe(count: Int) -> SearchRecipe {
        let searchRecipe = SearchRecipe(hits: createHit(), count: count)
        return searchRecipe
    }
    
    func testAddRecipeOfArray() {
        
        recipeSearch.addRecipeOfArray(recipeSearch: createSearchRecipe(count: 8))
        
        XCTAssertNotEqual(recipeSearch.listRecipe.count, 0)
        XCTAssertNotEqual(recipeSearch.listRecipe.count, 1)
        XCTAssertEqual(recipeSearch.listRecipe.count, 3)
        XCTAssertEqual(recipeSearch.listRecipe[0].label, "chicken Visuo")
    }

    func testCountIsNul() {
        let searchRecipe = createSearchRecipe(count: 0)
        
        let result = recipeSearch.countIsNul(recipeSearch: searchRecipe)
        
        XCTAssertEqual(result, true)
    }

    func testCountIsNulForNotNul() {
        let searchRecipe = createSearchRecipe(count: 8)
        
        let result = recipeSearch.countIsNul(recipeSearch: searchRecipe)
        
        XCTAssertEqual(result, false)
    }

    func testPrepareForRequestInTableView() {
        Constant.numberResult = "95"
        
        recipeSearch.prepareForRequestInTableView()
        
        XCTAssertEqual(Constant.numberResult, "100")
    }
    
    //MARK: -Function request
    func testRequestNil() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: TestError.error)
        let recipeSearch1 = RecipeSearch(recipeServiceSession: RecipeService(recipeSession: RecipeSessionFake(fakeResponse: fakeResponse)))
        let ingredient = "chicken"
        
        recipeSearch1.executeRequest(ingredient: ingredient)
        
        XCTAssertEqual(recipeSearch1.listRecipe.count, 0)
        XCTAssertEqual(recipeSearch1.errorRequest, ErrorMessage.networkError)
    }
    
    func testRequest() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeCorrectData, error: nil)
        let recipeSearch1 = RecipeSearch(recipeServiceSession: RecipeService(recipeSession: RecipeSessionFake(fakeResponse: fakeResponse)))
        let ingredient = "chicken"
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        recipeSearch1.executeRequest(ingredient: ingredient)
        
        XCTAssertEqual(recipeSearch1.listRecipe.count, 2)
        XCTAssertEqual(recipeSearch1.listRecipe[0].label, "Chicken Vesuvio")
        XCTAssertEqual(recipeSearch1.listRecipe[1].label, "Chicken Paprikash")
        XCTAssertNil(recipeSearch1.errorRequest)
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 0.01)
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
    
}
