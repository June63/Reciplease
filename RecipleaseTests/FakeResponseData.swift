//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Léa Kieffer on 15/12/2021.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Response
    static var responseOK = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static var responseKO = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    // MARK: - Data
    static var recipeCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "recipe", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let recipeIncorrectData = "erreur".data(using: .utf8)!
    
}

class TestError: Error {
    static let error = TestError()
}

