//
//  EndViewController3.swift
//  Coursework
//
//  Created by Jason Hitching on 06/01/2020.
//  Copyright © 2020 Jason Hitching. All rights reserved.
//

import UIKit

class EndViewController3: UIViewController {
    
    @IBOutlet var replayButton3: UIButton!
    @IBOutlet var homeButton3: UIButton!
    @IBOutlet var scoreLabel4: UILabel!

    var scoreData:String!
    
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // backgroundSetup()
        setupReplayButton()
        setupHomeButton()
        gameOverImg()
        
        scoreLabel4.frame = CGRect(x:W/2.58, y:H/1.8, width: 150, height: 50)
        scoreLabel4.text = "Final score: " + scoreData
        
    }
    
    // Initialise replay button
    func setupReplayButton() {
        self.view.bringSubviewToFront(replayButton3)
        replayButton3.frame = CGRect(x:W/2.58, y:H/1.35, width: 50, height: 50)
    }
    
    func setupHomeButton() {
        self.view.bringSubviewToFront(homeButton3)
        homeButton3.frame = CGRect(x:W/1.92, y:H/1.35, width: 51, height: 51)
    }
    
    // Game over image
    func gameOverImg() {
        let gameOver = UIImageView(image: UIImage(named: "gameOver.png"))
        gameOver.frame = CGRect(x:W/2.58, y:H/100, width: 150, height: 180)
        self.view.addSubview(gameOver)
        self.view.bringSubviewToFront(gameOver)
    }
}
