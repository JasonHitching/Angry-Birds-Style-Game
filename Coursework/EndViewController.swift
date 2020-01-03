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
    
    let replayButton = ReplayButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background img
        let bgView = UIImageView(image: nil)
        bgView.image = UIImage(named: "bg2.png")
        bgView.frame = UIScreen.main.bounds
        self.view.addSubview(bgView)
    
        //Game over
        let gameOver = UIImageView(image: UIImage(named: "gameOver.png"))
        gameOver.frame = CGRect(x:W/2.9, y:H/14, width: 200, height: 200)
        self.view.addSubview(gameOver)
        self.view.bringSubviewToFront(gameOver)
        
        setupReplayButton()
        addActionToReplayButton()
    }
    
    func setupReplayButton(){
        replayButton.frame = CGRect(x:W/2.9, y:H/1.5, width: 200, height: 50)
        view.addSubview(replayButton)
        view.bringSubviewToFront(replayButton)
        replayButton.setTitle("Replay", for: .normal)
        replayButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    func addActionToReplayButton() {
        replayButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        replayButton.shake()
        restart()
    }
    
    func restart() {
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
