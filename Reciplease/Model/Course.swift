//
//  Course.swift
//  Reciplease
//
//  Created by Léa Kieffer on 05/12/2021.
//

import UIKit

class Course {
    let name: String
    let color: UIColor
    var isSelected: Bool

    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
        isSelected = true
    }
}

