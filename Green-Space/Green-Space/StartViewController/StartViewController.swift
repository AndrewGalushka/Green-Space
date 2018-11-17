//
//  ViewController.swift
//  Green-Space
//
//  Created by Galushka on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    fileprivate var gameScreen: GameViewController?
    fileprivate var startTapGesture: UITapGestureRecognizer!
    fileprivate let fadeView = FadeView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Design.Colors.background

        titleLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)

        logoImageView.layer.removeAllAnimations()
        logoImageView.transform = CGAffineTransform.identity
        
        startTapGesture = UITapGestureRecognizer(target: self, action: #selector(startGame))
        logoImageView.addGestureRecognizer(startTapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) {
            self.titleLabel.transform = CGAffineTransform.identity
        }
        
    }

    @objc fileprivate func startGame() {
        fadeView.backgroundColor = .white
        view.addSubview(fadeView)
        fadeView.startFadeOut(delegate: self)

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 1;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = HUGE;
        
        logoImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            self.logoImageView.layer.timeOffset = self.logoImageView.layer.convertTime(CACurrentMediaTime(), from: nil)
            self.logoImageView.layer.beginTime = CACurrentMediaTime()
            self.logoImageView.layer.speed += 0.3
        }
        timer.fire()
    }
}

// MARK: - CAAnimationDelegate
extension StartViewController: FadeViewDelegate {
    
    internal func animationDidStop() {
        logoImageView.isHidden = true
        fadeView.removeFromSuperview()
        
        let vc = GameViewController.instantiateFromStoryboard()
        gameScreen = vc
        
        present(vc, animated: false) {}
    }
}
