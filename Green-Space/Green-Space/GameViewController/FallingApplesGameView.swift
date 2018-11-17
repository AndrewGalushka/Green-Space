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
        print(randXCoordinate(forAppleSize: appleSize))
    }
    
    func addApple() {
    }
    
    func randXCoordinate(forAppleSize: CGSize) -> CGFloat {
        let contentViewWidth = bounds.width
        let appleWidth = appleSize.width
        let randXCoordinate = CGFloat.random(in: 0...(contentViewWidth - appleWidth))
        
        return randXCoordinate
    }
}
