//
//  ExtensionFavoriteTableViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import UIKit

extension FavoriteTableViewController: ManageCoreDataDelegate {
    func alertWithCoreData(error: ErrorMessage) {
        presentAlert(error: error)
    }
}

extension FavoriteTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }
}
