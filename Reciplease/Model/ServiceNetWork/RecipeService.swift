//
//  RecipeService.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import Alamofire

class RecipeService {

    private var recipeSession: RecipeSession
    
    init(recipeSession: RecipeSession) {
        self.recipeSession = recipeSession
    }

    func getCurrentRecipe(currentSearch: String, completion: @escaping (ErrorMessage?,SearchRecipe?) -> Void) {
        Constant.ingredient = currentSearch
        let url: URLConvertible!
        url = Router2.searchRecipe
        self.recipeSession.request(url: url) { data in
            guard data.response?.statusCode == 200 else {
                switch data.response?.statusCode {
                case 301: print("redirection, respectivement permanente et temporaire")
                case 401:print(" utilisateur non authentifié ")
                case 403:print(" accès refusé")
                case 404:print("page non trouvée")
                case 429:print("limite request atteinte")
                case 500, 503:print("erreur serveur")
                case 504:print("le serveur n'a pas répondu")
                default:break
                }
                completion(ErrorMessage.networkError,nil)
                return
            }
            guard let data = data.data else {
                completion(ErrorMessage.errorNoSource,nil)
                return
            }
           guard let searchRecipe = try? JSONDecoder().decode(SearchRecipe.self, from: data) else {
                completion(ErrorMessage.errorParsingJson,nil)
                return
            }
            completion(nil,searchRecipe)
        }
    }
}

