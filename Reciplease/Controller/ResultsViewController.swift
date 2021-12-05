//
//  ResultsViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import UIKit

class ResultsViewController: UITableViewController {

    // MARK: - PROPERTIES
    var ingredients = [String]()

    var maxTotalTimeInSeconds: Int32 = 0

    private var selectedRow: Int!
    private var isLoading = false
    private var startIndex = 0
    private let cellId = "customRecipeCell"


    // MARK: - METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = backgroundView()
        tableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    // background view with activity indicator
    private func backgroundView() -> UIView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .whiteLarge
        activityIndicator.color = UIColor(named: "Color_text")
        activityIndicator.startAnimating()
        return activityIndicator
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 6
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 6
    }

}


