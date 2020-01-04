//
//  EndViewController.swift
//  Coursework
//
//  Created by Jason Hitching on 02/01/2020.
//  Copyright © 2020 Jason Hitching. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    @IBOutlet var replayButton: UIButton!
    @IBOutlet var homeButton: UIButton!
    
    @IBOutlet var scoreLabel: UILabel!
    var scoreData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // backgroundSetup()
        setupReplayButton()
        setupHomeButton()
        gameOverImg()
        
        scoreLabel.frame = CGRect(x:W/2.58, y:H/1.8, width: 150, height: 50)
        scoreLabel.text = "Final score: " + scoreData
        
    }
    
//    // Setup background image
//    func backgroundSetup() {
//        let bgView = UIImageView(image: nil)
//        bgView.image = UIImage(named: "bg2.png")
//        bgView.frame = UIScreen.main.bounds
//        self.view.addSubview(bgView)
//    }
    
    // Initialise replay button
    func setupReplayButton() {
        self.view.bringSubviewToFront(replayButton)
        replayButton.frame = CGRect(x:W/2.58, y:H/1.35, width: 50, height: 50)
    }
    
    func setupHomeButton() {
        self.view.bringSubviewToFront(homeButton)
        homeButton.frame = CGRect(x:W/1.92, y:H/1.35, width: 51, height: 51)
    }
    
    // Game over image
    func gameOverImg() {
        let gameOver = UIImageView(image: UIImage(named: "gameOver.png"))
        gameOver.frame = CGRect(x:W/2.58, y:H/100, width: 150, height: 180)
        self.view.addSubview(gameOver)
        self.view.bringSubviewToFront(gameOver)
    }
}
