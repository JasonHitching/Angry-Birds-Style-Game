//
//  StartViewController.swift
//  Coursework
//
//  Created by Jason Hitching on 03/01/2020.
//  Copyright © 2020 Jason Hitching. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet var levelOne: UIButton!
    @IBOutlet var levelTwo: UIButton!
    @IBOutlet var levelThree: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var credits: UILabel!
    
    //Retrieve width & height of current phone screen
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelOneButton()
        levelTwoButton()
        levelThreeButton()
        
        // Background img
        let bg1View = UIImageView(image: nil)
        bg1View.image = UIImage(named: "BG1.png")
        bg1View.frame = UIScreen.main.bounds
        self.view.addSubview(bg1View)
        self.view.sendSubviewToBack(bg1View)
        
        nameLabel.frame = CGRect(x:W / 45, y: H/1.2, width: 500, height: 80)
        credits.frame = CGRect(x: W / 2.1, y: H/1.19, width: 600, height: 80)
   
    }
    
       func levelOneButton() {
        levelOne.frame = CGRect(x:W/2.58, y:H/3.8, width: 150, height: 90)
       }
       
       func levelTwoButton() {
        levelTwo.frame = CGRect(x:W/2.58, y:H/2.45, width: 150, height: 90)
       }
       
       func levelThreeButton() {
        levelThree.frame = CGRect(x:W/2.58, y:H/1.8, width: 150, height: 90)
       }
}
