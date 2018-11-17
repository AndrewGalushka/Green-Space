//
//  GameViewController.swift
//  Green-Space
//
//  Created by Galushka on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var fallingApplesGameView: FallingApplesGameView!
    
    fileprivate let fadeView = FadeView(frame: UIScreen.main.bounds)
    fileprivate let startMessageLable = UILabel(frame: UIScreen.main.bounds)
    fileprivate let message1 = "Помоги "
    fileprivate let messageDaria = "Даше"
    fileprivate let messageKaren = "Карену"
    fileprivate let message2 = "iPhone отделу собрать яблоки"
    fileprivate let queue = OperationQueue()
    let imageGenerator = ImageGenerator()
    
    var successHitCounter = 0
    var failureHitCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        fallingApplesGameView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fadeView.startFadeIn(delegate: self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupDesign() {
        fadeView.backgroundColor = .white
        startMessageLable.backgroundColor = Design.Colors.background
        startMessageLable.textColor = .white
        startMessageLable.text = ""
        startMessageLable.font = UIFont(name: "Marker Felt", size: 40)
        startMessageLable.numberOfLines = 0
        startMessageLable.lineBreakMode = .byWordWrapping
        view.backgroundColor = Design.Colors.background
        view.addSubview(fadeView)
    }
    
    func startGame() {
        fallingApplesGameView.start()
    }
    
    func showImage(_ image: UIImage) {
        let rect = CGRect(x: -view.bounds.width / 4, y: -view.bounds.height / 4, width: view.bounds.width / 2.0, height: view.bounds.height / 2.0)
        let imageView = UIImageView(frame: rect)
        imageView.alpha = 0.8
        imageView.image = image
        
        view.insertSubview(imageView, aboveSubview: fallingApplesGameView)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            imageView.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            imageView.transform = CGAffineTransform.init(rotationAngle: 0.523599)
        }) { (flag) in
//            imageView.alpha = 1.0
//            imageView.removeFromSuperview()
        }
    }
}

extension GameViewController: FadeViewDelegate {
    
    internal func animationDidStop() {
        fadeView.removeFromSuperview()
        
        view.addSubview(startMessageLable)
        startMessage1Typing()
    }
}

extension GameViewController {
    
    func startMessage1Typing() {
        let delay = 0.3
        var summedDelay = delay
        
        queue.maxConcurrentOperationCount = 1
        queue.addOperation {
            self.message1.forEach { char in
                DispatchQueue.main.asyncAfter(deadline: .now() + summedDelay, execute: {
                    print(char)
                    self.startMessageLable.text?.append(char)
                })
                
                summedDelay += delay
            }
        }
        
        queue.addOperation {
        self.messageDaria.forEach { char in
            DispatchQueue.main.asyncAfter(deadline: .now() + summedDelay, execute: {
                print(char)
                self.startMessageLable.text?.append(char)
            })
            
            summedDelay += delay
        }
        
        summedDelay += 1
        }
        
        queue.addOperation {
        self.messageDaria.forEach { char in
            DispatchQueue.main.asyncAfter(deadline: .now() + summedDelay, execute: {
                self.startMessageLable.text?.removeLast()
            })
            
            summedDelay += delay
        }
        }
        
        self.messageKaren.forEach { char in
            DispatchQueue.main.asyncAfter(deadline: .now() + summedDelay, execute: {
                print(char)
                self.startMessageLable.text?.append(char)
            })
            
            summedDelay += delay
        }
        
        summedDelay += 1
        
        queue.addOperation {
        self.messageKaren.forEach { char in
            DispatchQueue.main.asyncAfter(deadline: .now() + summedDelay, execute: {
                self.startMessageLable.text?.removeLast()
            })

            summedDelay += delay
        }
        }
        
        queue.addOperation {
        self.message2.forEach { char in
            DispatchQueue.main.asyncAfter(deadline: .now() + summedDelay, execute: {
                self.startMessageLable.text?.append(char)
            })
            
            summedDelay += delay
        }
        
        summedDelay += 1
        }
        
        queue.addOperation {
        DispatchQueue.main.asyncAfter(deadline: .now() + summedDelay, execute: {
            UIView.animate(withDuration: 1, animations: {
                self.startMessageLable.removeFromSuperview()
            }, completion: { flag in
                self.startGame()
            })
        })
        }
    }
}

extension GameViewController: FallingApplesGameViewDelegate {
    func fallingApplesGameViewDidTapOnApple() {
        successHitCounter += 1
        
        if successHitCounter == 10 {
            let finishVC = FinalViewController.instantiateFromStoryboard()
            self.present(finishVC, animated: true, completion: nil)
        }
        
        if successHitCounter % 2 == 0 {
            showImage(imageGenerator.imageForSuccess())
        }
        
        print("failureHits:\(failureHitCounter), successHists:\(successHitCounter)")
    }
    
    func fallingApplesGameViewDidFailApple() {
        failureHitCounter += 1
        
        if failureHitCounter % 2 == 0 {
            showImage(imageGenerator.imageForFailure())
        }
        
        print("failureHits:\(failureHitCounter), successHists:\(successHitCounter)")
    }
}
