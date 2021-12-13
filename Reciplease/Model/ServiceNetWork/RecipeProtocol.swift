//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import Alamofire

protocol RecipeProtocol {
    func request(url: URLConvertible, completionHandler: @escaping (AFDataResponse<Data>) -> Void)
}
