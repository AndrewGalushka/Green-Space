//
//  FallingApplesGameView.swift
//  Green-Space
//
//  Created by Galushka on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class FallingApplesGameView: UIView {
    
    let appleSize = CGSize(width: 50, height: 50)
    let initailApearnceInterval = 1.0
    
    var timer: Timer?
    var apples = [CALayer]()
    
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
                             y: -appleSize.height)
        let cornerRadius = max(appleSize.width, appleSize.height) / 2
        let bkColor = UIColor.red.cgColor
        let animationEndPoint = CGPoint(x: randXCoordinate(forAppleSize: appleSize),
                                        y: bounds.height)
        
        let appleLayer = CALayer()
        appleLayer.frame = CGRect(x: origin.x, y: origin.y, width: appleSize.width, height: appleSize.height)
        appleLayer.cornerRadius = cornerRadius
        appleLayer.backgroundColor = bkColor
        
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
        
        let dropAnimation = CASpringAnimation(keyPath: "position")
        dropAnimation.fromValue = startPoint
        dropAnimation.toValue = endPoint
        dropAnimation.damping = 12.0
        dropAnimation.duration = 20.0
        dropAnimation.initialVelocity = -10.0
//        dropAnimation.initialVelocity = -2.0
//        dropAnimation.mass = 2.0
        
        return dropAnimation
    }
}
