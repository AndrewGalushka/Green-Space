//
//  GameViewController.swift
//  Green-Space
//
//  Created by Galushka on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var fallingApplesGameView: FallingApplesGameView!
    
    fileprivate let fadeView = FadeView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fadeView.startFadeIn(delegate: self)
    }
    
    func setupDesign() {
        fadeView.backgroundColor = .white
        view.backgroundColor = Design.Colors.background
        view.addSubview(fadeView)
    }
    
    func startGame() {
        fallingApplesGameView.start()
    }
}

extension GameViewController: CAAnimationDelegate {
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        fadeView.removeFromSuperview()
    }
}
