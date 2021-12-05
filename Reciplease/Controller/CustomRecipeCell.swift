//
//  CustomRecipeCell.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import UIKit

class CustomRecipeCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet var recipeRating: [UIImageView]!
    @IBOutlet weak var recipeCookingTime: UILabel!

    // MARK: - METHODS
 
    private func resetCell() {
        background.backgroundColor = UIColor.lightGray
        recipeName.text = ""
        recipeImage.image = UIImage(named: "noImage")
        recipeIngredients.text = ""
        recipeCookingTime.text = ""
        for star in recipeRating {
            star.image = UIImage(named: "star_false")
        }
    }

    private func setCellDesign() {
        recipeImage.layer.borderWidth = 2
        recipeImage.layer.cornerRadius = 20
        recipeImage.layer.borderColor = UIColor.white.cgColor
        background.layer.borderWidth = 2
        background.layer.cornerRadius = 20
        background.layer.borderColor = UIColor.white.cgColor
    }
}
