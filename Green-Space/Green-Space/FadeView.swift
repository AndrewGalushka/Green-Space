//
//  FadeView.swift
//  Green-Space
//
//  Created by Mike Kholomeev on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

protocol FadeViewDelegate: class {
    func animationDidStop()
}

class FadeView: UIView {

    fileprivate weak var delegate: FadeViewDelegate?
    
    func startFadeIn(delegate: FadeViewDelegate) {
        self.delegate = delegate
        
        let opacitiAnimation = CABasicAnimation(keyPath: "opacity")
        opacitiAnimation.fromValue = 1
        opacitiAnimation.toValue = 0
        opacitiAnimation.repeatCount = 1
        opacitiAnimation.duration = 1
        opacitiAnimation.isCumulative = true
        opacitiAnimation.delegate = self
        layer.add(opacitiAnimation, forKey: "opacity")
    }

    func startFadeOut(delegate: FadeViewDelegate) {
        self.delegate = delegate
        
        let opacitiAnimation = CABasicAnimation(keyPath: "opacity")
        opacitiAnimation.fromValue = 0
        opacitiAnimation.toValue = 1
        opacitiAnimation.repeatCount = 1
        opacitiAnimation.duration = 1
        opacitiAnimation.isCumulative = true
        opacitiAnimation.delegate = self
        layer.add(opacitiAnimation, forKey: "opacity")
    }
}

extension FadeView:CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegate?.animationDidStop()
    }
}
