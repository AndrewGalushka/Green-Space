//
//  AppleGameBackgroundImageGivver.swift
//  Green-Space
//
//  Created by Galushka on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

protocol AppleGameBackgroundImageGivver: class {
    func imageForSuccess() -> UIImage
    func imageForFailure() -> UIImage
}

extension AppleGameBackgroundImageGivver {
    
    func imageForSuccess() -> UIImage {
        return UIImage()
    }
    
    func imageForFailure() -> UIImage {
        return UIImage()
    }
}
