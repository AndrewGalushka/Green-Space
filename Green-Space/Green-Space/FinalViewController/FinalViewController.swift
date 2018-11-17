//
//  FinalViewController.swift
//  Green-Space
//
//  Created by ostrovskiy on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit
import SwiftFireworks

class FinalViewController: UIViewController {

    @IBOutlet private weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDesign()
        messageLabel.alpha = 0.0
    }

    func setupDesign() {
        view.backgroundColor = Design.Colors.background
        messageLabel.text = "happy birthday".uppercased()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let timer = Timer(timeInterval: 0.1, repeats: true) { (timer) in
             SwiftFireworks.sharedInstance.showFirework(inView: self.view, andPosition: CGPoint(x: CGFloat.random(in: 0...self.view.bounds.width), y: CGFloat.random(in: 0...self.view.bounds.height)))
        }

        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.25, animations: {
                self.messageLabel.alpha = 1.0
            })
        }
    }
}
