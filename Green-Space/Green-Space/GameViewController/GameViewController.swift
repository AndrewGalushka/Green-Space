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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fadeView.startFadeIn(delegate: self)
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
