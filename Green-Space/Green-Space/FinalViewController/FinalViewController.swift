//
//  FinalViewController.swift
//  Green-Space
//
//  Created by ostrovskiy on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    @IBOutlet private weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDesign()
    }

    func setupDesign() {
        view.backgroundColor = Design.Colors.background
        messageLabel.text = "happy birthday".uppercased()

    }
}
