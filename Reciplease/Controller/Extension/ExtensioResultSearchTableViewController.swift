//
//  ExtensioResultSearchTableViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import UIKit

extension ResultSearchTableViewController: ResultRequest {
    func resultOfSearch() {
        tableViewList.removeLoadingScreen(loadingView: loadingView, spinner: spinner, loadingLabel: loadingLabel)
        self.tableView.reloadData()
    }

    func resultAlert(error: ErrorMessage) {
        tableViewList.removeLoadingScreen(loadingView: loadingView, spinner: spinner, loadingLabel: loadingLabel)
        presentAlert(error: error)
        tableViewList.setEmptyMessage(Constant.messageSearchTableView)
    }
}

