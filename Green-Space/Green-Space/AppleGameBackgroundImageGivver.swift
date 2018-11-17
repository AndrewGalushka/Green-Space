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

class ImageGenerator: AppleGameBackgroundImageGivver {

    var badImages: [UIImage] = [#imageLiteral(resourceName: "bad-1.jpg"), #imageLiteral(resourceName: "bad-2.jpg"), #imageLiteral(resourceName: "bad-3.jpg"), #imageLiteral(resourceName: "bad-3.jpg"), #imageLiteral(resourceName: "bad-6.jpg"), #imageLiteral(resourceName: "bad-9.jpg"), #imageLiteral(resourceName: "bad-10.jpg"), #imageLiteral(resourceName: "bad-13.jpg")]
    var goodImages: [UIImage] = [#imageLiteral(resourceName: "good-5.jpg"), #imageLiteral(resourceName: "good-7.jpg"), #imageLiteral(resourceName: "good-8.jpg"), #imageLiteral(resourceName: "good-11.jpg"), #imageLiteral(resourceName: "good-12.jpg"), #imageLiteral(resourceName: "good-14.jpg"), #imageLiteral(resourceName: "good-15.jpg"), #imageLiteral(resourceName: "good-16.jpg")]

    func imageForSuccess() -> UIImage {
        let randomInt = Int.random(in: 0..<goodImages.count)
        return goodImages[randomInt]
    }

    func imageForFailure() -> UIImage {
        let randomInt = Int.random(in: 0..<badImages.count)
        return badImages[randomInt]
    }
}
