//
//  RecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Léa Kieffer on 15/12/2021.
//

import Foundation
import Alamofire
@testable import Reciplease

class RecipeSessionFake: RecipeSession {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    override func request(url: URLConvertible, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        let result = Request.serializeResponseData(response: httpResponse, data: data, error: error)
        
        let url = Router2.searchRecipe
         let urlRequest = try? URLRequest(url: url, method: .get)
         completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
  
}
struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}

