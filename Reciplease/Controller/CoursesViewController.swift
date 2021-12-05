//
//  CoursesViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 02/12/2021.
//

import UIKit

protocol CoursesViewControllerDelegate {
    func setCourseButtonTitle(with title: String)
}

class CoursesViewController: UIViewController {

    @IBOutlet weak var courseTableView: UITableView!
    @IBOutlet weak var contentView: UIView!

    var delegate: CoursesViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setup() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }

}
