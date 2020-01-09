//
//  EndViewController3.swift
//  Coursework
//
//  Created by Jason Hitching on 06/01/2020.
//  Copyright © 2020 Jason Hitching. All rights reserved.
//

import UIKit

class EndViewController3: UIViewController {
    
    @IBOutlet var home: UIButton!
    @IBOutlet var replay: UIButton!
    @IBOutlet var nextLevel: UIButton!
    
    @IBOutlet var scoreLabel4: UILabel!

    var scoreData:String!
    
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // backgroundSetup()
        
        gameOverImg()
        replayLevelButton()
        homeButton()
        backgroundSetup()
        
        let labelImg = UIImageView(image: UIImage(named: "12.png"));
        labelImg.frame = CGRect(x:W/2.93, y:H/3.4, width: 200, height: 90)
        self.view.addSubview(labelImg)
        
        scoreLabel4.frame = CGRect(x:W/2.5, y:H/2.9, width: 200, height: 50)
        scoreLabel4.text = "Final score: " + scoreData
        self.view.bringSubviewToFront(scoreLabel4)
        
    }

    
    
    func replayLevelButton() {
        replay.frame = CGRect(x:W/2.63, y:H/2.2, width: 150, height: 90)
    }
    
    func homeButton() {
        home.frame = CGRect(x:W/2.63, y:H/1.6, width: 150, height: 90)
    }
    

    
    // Game over image
    func gameOverImg() {
        let gameOver = UIImageView(image: UIImage(named: "game.png"))
        gameOver.frame = CGRect(x:W/3.7, y:H/13, width: 300, height: 80)
        self.view.addSubview(gameOver)
        self.view.bringSubviewToFront(gameOver)
    }
    
    // Setup background image
    func backgroundSetup() {
        let bgView = UIImageView(image: nil)
        bgView.image = UIImage(named: "BG1")
        bgView.frame = UIScreen.main.bounds
        self.view.addSubview(bgView)
        self.view.sendSubviewToBack(bgView)
    }
}
