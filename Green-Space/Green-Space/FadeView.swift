//
//  FadeView.swift
//  Green-Space
//
//  Created by Mike Kholomeev on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class FadeView: UIView {

    func startFadeIn(delegate: CAAnimationDelegate) {
        let opacitiAnimation = CABasicAnimation(keyPath: "opacity")
        opacitiAnimation.fromValue = 1
        opacitiAnimation.toValue = 0
        opacitiAnimation.repeatCount = 1
        opacitiAnimation.duration = 1
        opacitiAnimation.isCumulative = true
        opacitiAnimation.delegate = delegate
        layer.add(opacitiAnimation, forKey: "opacity")
    }

    func startFadeOut(delegate: CAAnimationDelegate) {
        let opacitiAnimation = CABasicAnimation(keyPath: "opacity")
        opacitiAnimation.fromValue = 0
        opacitiAnimation.toValue = 1
        opacitiAnimation.repeatCount = 1
        opacitiAnimation.duration = 1
        opacitiAnimation.isCumulative = true
        opacitiAnimation.delegate = delegate
        layer.add(opacitiAnimation, forKey: "opacity")
    }
}
