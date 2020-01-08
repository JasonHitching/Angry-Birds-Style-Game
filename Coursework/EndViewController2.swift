//
//  EndViewController2.swift
//  Coursework
//
//  Created by Jason Hitching on 04/01/2020.
//  Copyright © 2020 Jason Hitching. All rights reserved.
//

import UIKit

class EndViewController2: UIViewController {

    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    @IBOutlet var nextLevel: UIButton!
    @IBOutlet var replay: UIButton!
    @IBOutlet var home: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    var scoreData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // backgroundSetup()
        nextLevelButton()
        replayLevelButton()
        homeButton()
        gameOverImg()
        
        scoreLabel.frame = CGRect(x:W/2.58, y:H/2.3, width: 150, height: 50)
        scoreLabel.text = "Final score: " + scoreData
    }
    
    
    func nextLevelButton() {
        nextLevel.frame = CGRect(x:W/2.6, y:H/1.8, width: 150, height: 50)
    }
    
    func replayLevelButton() {
        replay.frame = CGRect(x:W/2.63, y:H/1.5, width: 150, height: 50)
    }
    
    func homeButton() {
        home.frame = CGRect(x:W/2.63, y:H/1.3, width: 150, height: 50)
    }
    
    // Setup background image
//    func backgroundSetup() {
//        let bgView = UIImageView(image: nil)
//        bgView.image = UIImage(named: "bg2.png")
//        bgView.frame = UIScreen.main.bounds
//        self.view.addSubview(bgView)
//    }
    
    // Game over image
    func gameOverImg() {
        let gameOver = UIImageView(image: UIImage(named: "gameOver.png"))
        gameOver.frame = CGRect(x:W/2.9, y:H/100, width: 200, height: 180)
        self.view.addSubview(gameOver)
        self.view.bringSubviewToFront(gameOver)
    }
    
}
