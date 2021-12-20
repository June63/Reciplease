//
//  WebServiceSession.swift
//  Reciplease
//
//  Created by Léa Kieffer on 20/12/2021.
//

import Foundation
import Alamofire

protocol AlamofireSession {
    func fetchRecipes(keywords: [String], callback: @escaping (DataResponse<ResultRequest, AFError>) -> Void )
}

final class WebServiceSession: AlamofireSession {
    private let appKey = "e34a263a1d35723913661e204160541e"
    private let appId = "07a3e0af"
    private let url = "https://api.edamam.com/search"

    func fetchRecipes(keywords: [String], callback: @escaping (DataResponse<ResultRequest, AFError>) -> Void ) {
        let query: String = keywords.joined(separator: ", ")
        let parameters: [String: String] = [ "app_key": appKey, "app_id": appId, "q": query ]

        AF.request(url, method: .get, parameters: parameters)
            .responseDecodable(of: ResultRequest.self) { (response) in
                callback(response)
        }
    }
}

