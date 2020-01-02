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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background img
        let bgView = UIImageView(image: nil)
        bgView.image = UIImage(named: "bg.jpg")
        bgView.frame = UIScreen.main.bounds
        self.view.addSubview(bgView)
    
        //Game over
        let gameOver = UIImageView(image: UIImage(named: "gameOver.png"))
        gameOver.frame = CGRect(x:W/2.9, y:H/14, width: 200, height: 200)
        self.view.addSubview(gameOver)
        self.view.bringSubviewToFront(gameOver)

    }
    
}
