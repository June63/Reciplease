//
//  AlertEnum.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import Foundation

// All texts for alert messages
enum ErrorMessage: Error {
    case networkError,unknowError,errorNoSource,errorIngredientneeded,errorRecipeLoaded,errorNoDelete,errorAlwayFavorite,errorDeleteFavorite,errorAddFavorite,errorNoResult,error200,errorParsingJson,limitResult
    
    
    var title: String {
        switch self {
        case .networkError, .unknowError, .errorNoSource, .error200,.errorParsingJson:
            return "Alert Network"
        // Search recipe Error messages
        case .errorIngredientneeded,.errorNoDelete,.errorRecipeLoaded:
            return "Alert Ingredient"
        //  Detail favorite Error messages
        case .errorAlwayFavorite,.errorDeleteFavorite,.errorAddFavorite:
            return "Alert Favoris"
        case .errorNoResult:
            return "Alert Result"
        case .limitResult:
            return "Alert Limit"
        }
    }
    
    // global  Error messages
    var message: String {
        switch self {
        case .networkError:
            return "NetWork error"
        case .unknowError:
            return "Unknow error"
        case .errorNoSource:
            return "No source"
        case .error200:
            return "StatusCode != 200"
        // Search recipe Error messages
        case .errorIngredientneeded:
            return "need some ingredients"
        case .errorRecipeLoaded:
            return "Error no recipe loaded"
        case .errorNoDelete:
            return "No delete possible"
        //  Detail favorite Error messages
        case .errorAlwayFavorite:
            return "Always favorite"
        case .errorDeleteFavorite:
            return "Error Delete failded"
        case .errorAddFavorite:
            return "Error Add failded"
        case .errorNoResult:
            return "No result, either the combination of ingredients gives nothing, or an ingredient is poorly written"
        case .errorParsingJson:
            return "No parsing Json"
        case .limitResult:
            return "Limit number recipe 100"
        }
    }
}


