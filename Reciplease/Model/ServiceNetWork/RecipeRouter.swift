//
//  RecipeRouter.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import Alamofire

enum Router2: URLConvertible {

    func asURL() throws -> URL {
        let urlString = URL(string: Constant.baseURL)!
        let urlPath = urlString.appendingPathComponent(path)
        var urlComponent = URLComponents(url: urlPath, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let params1 = param1
        for (key,value) in params1 {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        let params = param
        for (key,value) in params {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponent?.queryItems = items
        let urlComplete = urlComponent?.url
        return urlComplete!
    }

    static let baseURLString = Constant.baseURL
    
    case searchRecipe
    
    var path: String {
        switch self {
        case .searchRecipe:
            return "search"
        }
    }
    
    var param1: [String:String] {
        switch self {
        case .searchRecipe:
            return ["app_id": Constant.appId]
        }
    }
    
    var param: [String:String] {
        switch self {
        case .searchRecipe:
            return ["app_key": Constant.appKey,
                    "q": Constant.ingredient,
                    "r": String(),
                    "to":Constant.numberResult,
                    "from": Constant.from
            ]
        }
    }
}

