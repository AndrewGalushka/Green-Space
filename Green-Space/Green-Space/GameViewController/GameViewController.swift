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
    let imageGenerator = ImageGenerator()
    
    var successHitCounter = 0
    var failureHitCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        fallingApplesGameView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fadeView.startFadeIn(delegate: self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupDesign() {
        fadeView.backgroundColor = .white
        view.backgroundColor = Design.Colors.background
        view.addSubview(fadeView)
    }
    
    func startGame() {
        fallingApplesGameView.start()
    }
    
    func showImage(_ image: UIImage) {
        let rect = CGRect(x: -view.bounds.width / 2, y: -view.bounds.height / 2, width: view.bounds.width / 2.0, height: view.bounds.height / 2.0)
        let imageView = UIImageView(frame: rect)
        imageView.alpha = 0.8
        imageView.image = image
        
        view.insertSubview(imageView, at: 0)
        
        UIView.animate(withDuration: 1.0, animations: {
            imageView.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            imageView.transform = CGAffineTransform.init(rotationAngle: 0.523599)
        }) { (completed) in
//            imageView.alpha = 1.0
//            imageView.removeFromSuperview()
        }
    }
}

extension GameViewController: CAAnimationDelegate {
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        fadeView.removeFromSuperview()
    }
}

extension GameViewController: FallingApplesGameViewDelegate {
    func fallingApplesGameViewDidTapOnApple() {
        successHitCounter += 1
        showImage(imageGenerator.imageForSuccess())
        print("failureHits:\(failureHitCounter), successHists:\(successHitCounter)")
    }
    
    func fallingApplesGameViewDidFailApple() {
        failureHitCounter += 1
        showImage(imageGenerator.imageForFailure())
        print("failureHits:\(failureHitCounter), successHists:\(successHitCounter)")
    }
}
