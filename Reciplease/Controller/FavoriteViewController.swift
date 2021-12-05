//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import UIKit

class FavoriteViewController: UITableViewController {

    // MARK: - PROPERTIES
    private let cellId = "customRecipeCell"

    // MARK: - METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.backgroundView = UINib(nibName: "NoFavorite", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 6
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 6
    }

}
