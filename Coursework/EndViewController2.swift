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
        backgroundSetup()
        
        let labelImg = UIImageView(image: UIImage(named: "12.png"));
        labelImg.frame = CGRect(x:W/13, y:H/12, width: 200, height: 90)
        self.view.addSubview(labelImg)
        
        scoreLabel.frame = CGRect(x:W/7.8, y:H/7.5, width: 200, height: 50)
        scoreLabel.text = "Final score: " + scoreData
        self.view.bringSubviewToFront(scoreLabel)
    }
    
    // Setup background image
    func backgroundSetup() {
        let bgView = UIImageView(image: nil)
        bgView.image = UIImage(named: "BG1")
        bgView.frame = UIScreen.main.bounds
        self.view.addSubview(bgView)
        self.view.sendSubviewToBack(bgView)
    }
    
    
    func nextLevelButton() {
        nextLevel.frame = CGRect(x:W/2.58, y:H/3.8, width: 150, height: 90)
    }
    
    func replayLevelButton() {
        replay.frame = CGRect(x:W/2.58, y:H/2.45, width: 150, height: 90)
    }
    
    func homeButton() {
        home.frame = CGRect(x:W/2.58, y:H/1.8, width: 150, height: 90)
    }
    
}
