//
//  DetailView.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import UIKit

final class DetailView: UIView {
    @IBOutlet weak var labelLike: UILabel!
    @IBOutlet weak var imageLike: UIImageView!
    @IBOutlet weak var labelTimeRecipe: UILabel!
    @IBOutlet weak var imageTime: UIImageView!
    
    var cornerRadiusValue: CGFloat = 20
    
    func instantiate(labelLikeText: String, labelTimeRecipeText: String) {
        labelLike.text = labelLikeText
        labelTimeRecipe.text = labelTimeRecipeText
        imageLike.image = UIImage(named: "jaimeb" )
        imageTime.image = UIImage(named: "essaiTime")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = cornerRadiusValue
    }
    
    
}
