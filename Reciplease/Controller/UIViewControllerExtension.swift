//
//  UIViewControllerExtension.swift
//  Reciplease
//
//  Created by Léa Kieffer on 23/12/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
