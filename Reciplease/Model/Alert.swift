//
//  Alert.swift
//  Reciplease
//
//  Created by Léa Kieffer on 08/12/2021.
//

import UIKit

class Alert {

    class func present(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        vc.present(alert, animated: true)
    }
}

