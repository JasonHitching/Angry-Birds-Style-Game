//
//  ViewController.swift
//  Coursework
//
//  Created by Jason Hitching on 04/12/2019.
//  Copyright © 2019 Jason Hitching. All rights reserved.
//

import UIKit

protocol subviewDelegate {
    func changeSomething()
}

class ViewController: UIViewController, subviewDelegate{
    
    func changeSomething() {
        let ballFrame = UIImageView(image: nil)
        ballFrame.image = UIImage(named: "ball.png")
        ballFrame.frame = CGRect(x: W/40, y: H/2.7, width: 80, height: 80)
        self.view.addSubview(ballFrame)
        
        
        dynamicItemBehavior = UIDynamicItemBehavior(items: balls)
        dynamicItemBehavior.addItem(ballFrame)
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        self.dynamicItemBehavior.addLinearVelocity(CGPoint(x:500, y:150), for: ballFrame)
        
        //Create phone screen side collisions
        collisionBehavior = UICollisionBehavior(items: [ballFrame])
        //collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: W, y: UIScreen.main.bounds.width))
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        }
    
    
    @IBOutlet weak var shooter: DragImageView!
    @IBOutlet weak var display: UILabel!
    
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var balls: [UIImageView] = []
    
    func setTranslatesReferenceBoundsIntoBoundary(with insets: UIEdgeInsets){
        
    }
    
    //Function to setup the shooter image & starting position
    func setupShooter(){
        shooter.image = UIImage(named: "aim.png")
        shooter.frame = CGRect(x: W/27, y: H/2.7, width: 80, height: 80)
        shooter.isUserInteractionEnabled = true

        //Make our images visible
        self.view.addSubview(shooter)
    }
    
    //Retrieve width & height of current phone screen
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        shooter.myDelegate = self
        
        setupShooter()
        
    }
}



