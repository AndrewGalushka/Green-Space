//
//  FallingApplesGameView.swift
//  Green-Space
//
//  Created by Galushka on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

protocol FallingApplesGameViewDelegate: class {
    func fallingApplesGameViewDidTapOnApple()
    func fallingApplesGameViewDidFailApple()
}

class FallingApplesGameView: UIView {
    
    let appleSize = CGSize(width: 50, height: 50)
    let initailApearnceInterval = 1.0
    
    var timer: Timer?
    var apples = [CALayer]()
    
    weak var delegate: FallingApplesGameViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerHandler(tapGesture:)))
        
        addGestureRecognizer(gesture)
    }
    
    func start() {
        timer = Timer(timeInterval: initailApearnceInterval, target: self, selector: #selector(timerTickActionHandler), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    func stop() {
        clean()
    }
    
    private func clean() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func timerTickActionHandler() {
        addApple()
    }
    
    func addApple() {
        let origin = CGPoint(x: randXCoordinate(forAppleSize: appleSize),
                             y: -bounds.height - safeAreaInsets.top)
        let cornerRadius = max(appleSize.width, appleSize.height) / 2
        let animationEndPoint = CGPoint(x: randXCoordinate(forAppleSize: appleSize),
                                        y: bounds.height + safeAreaInsets.bottom + appleSize.height)
        
        let appleLayer = CALayer()
        appleLayer.frame = CGRect(x: origin.x, y: origin.y, width: appleSize.width, height: appleSize.height)
        appleLayer.cornerRadius = cornerRadius
        appleLayer.backgroundColor = UIColor.clear.cgColor
        appleLayer.contents = UIImage(named: "apple2_colored")?.cgImage
        
        apples.append(appleLayer)
        layer.addSublayer(appleLayer)
        appleLayer.add(createDroppedAnimation(startPoint: origin, endPoint: animationEndPoint), forKey: nil)
    }
    
    func randXCoordinate(forAppleSize: CGSize) -> CGFloat {
        let contentViewWidth = bounds.width
        let appleWidth = appleSize.width
        let randXCoordinate = CGFloat.random(in: 0...(contentViewWidth - appleWidth))
        
        return randXCoordinate
    }
    
    func createDroppedAnimation(startPoint: CGPoint, endPoint: CGPoint) -> CAAnimation {
        
        let dropAnimation = CABasicAnimation(keyPath: "position")
        dropAnimation.fromValue = startPoint
        dropAnimation.toValue = endPoint
        dropAnimation.delegate = self
        dropAnimation.duration = 3.0
        dropAnimation.isRemovedOnCompletion = false
        dropAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        return dropAnimation
    }
    
    @objc func tapGestureRecognizerHandler(tapGesture: UITapGestureRecognizer) {
        
        guard tapGesture.state == .ended else { return }
        
        let location = tapGesture.location(in: self)
        
        for apple in apples {
            
            if apple.presentation()?.frame.contains(location) ?? false {
                
                CATransaction.begin()
                
                let opacityAmimation = CABasicAnimation(keyPath: "opacity")
                opacityAmimation.byValue = -1.0
                opacityAmimation.duration = 0.25
                opacityAmimation.delegate = self
                opacityAmimation.isRemovedOnCompletion = false
                opacityAmimation.fillMode = CAMediaTimingFillMode.forwards
                
                apple.add(opacityAmimation, forKey: nil)
                
                CATransaction.commit()
            }
        }
    }
}

extension FallingApplesGameView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        for apple in apples {
            
            if anim == apple.animation(forKey: "position") {
                apple.removeFromSuperlayer()
                
                let index = apples.index(of: apple)
                
                if let index = index {
                    apples.remove(at: index)
                    delegate?.fallingApplesGameViewDidTapOnApple()
                }
                
            } else if anim == apple.animation(forKey: "opacity") {
                apple.removeFromSuperlayer()
                
                let index = apples.index(of: apple)
                
                if let index = index {
                    apples.remove(at: index)
                    delegate?.fallingApplesGameViewDidFailApple()
                }
            }
        }
    }
}

