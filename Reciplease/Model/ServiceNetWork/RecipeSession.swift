//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import Alamofire

class RecipeSession {
    func request(url: URLConvertible, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
       AF.request(url).responseData { response in completionHandler(response) }
    }
 }
