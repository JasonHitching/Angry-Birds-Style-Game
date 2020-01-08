//
//  ViewController.swift
//  Coursework
//
//  Created by Jason Hitching on 04/12/2019.
//  Copyright © 2019 Jason Hitching. All rights reserved.
//

import UIKit

/* Delegation protocol */
protocol subviewDelegate {
    func fireBall()
    func updateCoord(X: Int, Y: Int)
}

class ViewController: UIViewController, subviewDelegate{
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var shooter: DragImageView!
    
    
    /* Dynamic/Collision Variables */
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    
    /* Array variables */
    var balls = [UIImageView]();
    var birdViews = [UIImageView]();
    var visibleBirds = [UIImageView]();
    
    /* Timer variables */
    var birdTimer:Timer?
    var gameTimer = Timer()
    
    var angleX:Int = 0
    var angleY:Int = 0
    var gameInt = 1
    var score = 0
    
    //Retrieve width & height of current phone screen
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    /* Function to fire the ball */
    func fireBall() {
        
        /* Create a new ball */
        let ballFrame = UIImageView(image: nil)
        ballFrame.image = UIImage(named: "ball.png")
        ballFrame.frame = CGRect(x: W/40, y: H/2.7, width: 60, height: 60)
        ballFrame.layer.cornerRadius = 30
        ballFrame.layer.masksToBounds = true
        
        
        /* Add the ball to the subview and append it to the 'balls' array */
        self.view.addSubview(ballFrame)
        balls.append(ballFrame)
        
        /* Implementation of ball motion dynamics */
        dynamicItemBehavior = UIDynamicItemBehavior(items: balls)
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        self.dynamicItemBehavior.addLinearVelocity(CGPoint(x:angleX, y:angleY), for: ballFrame)
        
        setupCollisions()
    }
    
    /* Update the shooter coordinates */
    func updateCoord(X: Int, Y: Int) {
        angleX = X*4
        angleY = Y*2
    }
    
    /* Initialise phone screen collision boundaries */
    func setupCollisions() {
        // Declare items to inherit collison behavior
        collisionBehavior = UICollisionBehavior(items: balls)
        // Implement left side phone screen boundary
        collisionBehavior.addBoundary(withIdentifier: "leftBounds" as NSCopying, from:
            CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: H))
        // Implement top phone screen boundary
        collisionBehavior.addBoundary(withIdentifier: "topBounds" as NSCopying, from:
            CGPoint(x: 0, y: 0), to: CGPoint(x: W, y:0))
        // Implement bottom screen boundary
        collisionBehavior.addBoundary(withIdentifier: "bottomBounds" as NSCopying, from:
            CGPoint(x: 0, y: H), to: CGPoint(x: W, y: H))
        
        dynamicAnimator.addBehavior(collisionBehavior)
        
        /* Ball & bird collision implementation */
        collisionBehavior.action = {
            for ballView in self.balls {
                for birds in self.visibleBirds {
                    if ballView.frame.intersects(birds.frame) {
                        
                        // Remove intersected bird from visibleBirds array
                        let index = self.visibleBirds.firstIndex(of: birds)
                        self.visibleBirds.remove(at: index!)
                        
                        // Check count of subviews before and after removal of birds
                        let before = self.view.subviews.count
                        birds.removeFromSuperview()
                        let after = self.view.subviews.count
                                        
                        //If a bird was removed from superview score += 1
                        if (before != after) {
                            self.score += 1
                            self.scoreLabel.text = "Score: " + String(self.score) }
                    }
                }
            }
        }
    }
    
    /* Initialise the crosshair image & starting position */
    func setupShooter() {
        shooter.image = UIImage(named: "aim.png")
        shooter.frame = CGRect(x: W/27, y: H/2.5, width: 80, height: 80)
        shooter.isUserInteractionEnabled = true

        // Set the crosshair image to visible
        self.view.addSubview(shooter)
    }
    
    /* ADD BIRD SPRITES TO THE BIRD ARRAY */
    func addBirds() {
        let birdFrame = UIImageView(image: UIImage(named: "enemy.png"))
        birdFrame.frame = CGRect(x: W/1.2, y: H/2.5, width: 80, height: 80)
        birdViews.append(birdFrame)
        
        let birdFrame2 = UIImageView(image: UIImage(named: "enemy.png"))
        birdFrame2.frame = CGRect(x: W/1.2, y: H/1.4, width: 80, height: 80)
        birdViews.append(birdFrame2)
        
        let birdFrame3 = UIImageView(image: UIImage(named: "enemy.png"))
        birdFrame3.frame = CGRect(x: W/1.2, y: H/11, width: 80, height: 80)
        birdViews.append(birdFrame3)
    }
    
    /* FUNCTION DEALING WITH THE RUNNING OF THE GAME */
    @objc func game() {
        // Each time game is called gameInt -= 1
        gameInt -= 1
        
        // If the game is 'over'
        if gameInt == 0 {
            // Invalidate the timer and call the end function
            gameTimer.invalidate()
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.end), userInfo: nil, repeats: false)
        }
    }
    
    /* Switch to the end game view */
    @objc func end() {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame")
                as! EndViewController
        vc.scoreData = String(self.score)
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func startGameTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.game), userInfo: nil, repeats: true)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameTimer()
        score = 0

        shooter.myDelegate = self
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)

        addBirds()
        setupShooter()

        // Background img
        let bg2View = UIImageView(image: nil)
        bg2View.image = UIImage(named: "bg.jpg")
        bg2View.frame = UIScreen.main.bounds
        self.view.addSubview(bg2View)
        self.view.sendSubviewToBack(bg2View)
                
        //Random bird appearance
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            
            let index = Int.random(in: 0 ... 2)
            if !self.visibleBirds.contains(self.birdViews[index]) {
                self.visibleBirds.append(self.birdViews[index])
                self.view.addSubview(self.birdViews[index])
            }
        }  
    }
}



