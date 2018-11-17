//
//  Extentions.swift
//  Green-Space
//
//  Created by Mike Kholomeev on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

extension UIViewController {
    class func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: String(describing: self))
    }
    
    class func instantiateFromStoryboard(storyboardName: String) -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: storyboardName)
    }
    
    private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T {
        let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboad.instantiateViewController(withIdentifier: storyboardName) as! T
        
        return controller
    }
}
