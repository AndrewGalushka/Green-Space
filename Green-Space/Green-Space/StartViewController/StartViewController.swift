//
//  ViewController.swift
//  Green-Space
//
//  Created by Galushka on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    
    fileprivate var gameScreen: GameViewController?
    fileprivate var startTapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.layer.removeAllAnimations()
        logo.transform = CGAffineTransform.identity
        
        startTapGesture = UITapGestureRecognizer(target: self, action: #selector(startGame))
        logo.addGestureRecognizer(startTapGesture)
    }

    @objc fileprivate func startGame() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 1;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = HUGE;
        logo.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            self.logo.layer.timeOffset = self.logo.layer.convertTime(CACurrentMediaTime(), from: nil)
            self.logo.layer.beginTime = CACurrentMediaTime()
            self.logo.layer.speed += 0.3
        }
        timer.fire()
        
        let opacitiAnimation = CABasicAnimation(keyPath: "opacity")
        opacitiAnimation.fromValue = 1
        opacitiAnimation.toValue = 0
        opacitiAnimation.repeatCount = 1
        opacitiAnimation.duration = 3
        opacitiAnimation.isCumulative = true
        opacitiAnimation.delegate = self
        logo.layer.add(opacitiAnimation, forKey: "opacity")
    }
}

// MARK: - CAAnimationDelegate
extension StartViewController: CAAnimationDelegate {
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        logo.isHidden = true
        
        let vc = GameViewController.instantiateFromStoryboard()
        
        gameScreen = vc
        
        present(vc, animated: false) {
            
        }
    }
}
