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
        
        scoreLabel4.frame = CGRect(x:W/2.58, y:H/2.3, width: 200, height: 50)
        scoreLabel4.text = "Final score: " + scoreData
        
    }

    
    
    func replayLevelButton() {
        replay.frame = CGRect(x:W/2.63, y:H/1.5, width: 150, height: 50)
    }
    
    func homeButton() {
        home.frame = CGRect(x:W/2.63, y:H/1.3, width: 150, height: 50)
    }
    

    
    // Game over image
    func gameOverImg() {
        let gameOver = UIImageView(image: UIImage(named: "gameOver.png"))
        gameOver.frame = CGRect(x:W/2.58, y:H/100, width: 150, height: 180)
        self.view.addSubview(gameOver)
        self.view.bringSubviewToFront(gameOver)
    }
}
