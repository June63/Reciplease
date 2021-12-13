//
//  CellCustom.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import UIKit

final class CellCustom: UITableViewCell {
    
    @IBOutlet weak var labelNameRecipe: UILabel!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var detailView: DetailView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        labelNameRecipe.textColor = UIColor.white
        // Configure the view for the selected state
    }
    
}

