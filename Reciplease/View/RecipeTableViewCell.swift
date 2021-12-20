//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import UIKit
import Alamofire

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var infosView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infosView.layer.cornerRadius = 4
    }

}
