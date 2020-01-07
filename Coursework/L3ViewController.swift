//
//  L3ViewController.swift
//  Coursework
//
//  Created by Jason Hitching on 06/01/2020.
//  Copyright © 2020 Jason Hitching. All rights reserved.
//

import UIKit

protocol subview3Delegate {
    func fireBall()
    func updateCoord(X: Int, Y: Int)
}

class L3ViewController: UIViewController, subview3Delegate{
    
    @IBOutlet var shooter: DragImageView!
    @IBOutlet var rockObstacle: UIImageView!
    
    //Global variables
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    
    var balls = [UIImageView]()
    var birdViews = [UIImageView]()
    var friendlyViews = [UIImageView]()

    var squareBarrier:UIImageView!
       
    var angleX:Int = 0
    var angleY:Int = 0
    var birdTimer:Timer?
    var gameTimer = Timer()
    var gameInt = 30
    var score = 0
       
    //Retrieve width & height of current phone screen
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    let rock = UIImageView(image: nil)

    /* Function to fire the ball from the shooter */
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

    func updateCoord(X: Int, Y: Int) {
       angleX = X*5
       angleY = Y*5
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
        
       collisionBehavior.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: rockObstacle.frame))
       collisionBehavior.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: rock.frame))
  
       /* BIRD COLLISIONS */
       collisionBehavior.action = {
           for ballView in self.balls {
               for birds in self.birdViews {
                for friendly in self.friendlyViews {
                   if ballView.frame.intersects(birds.frame) {
                       let before = self.view.subviews.count
                       birds.removeFromSuperview()
                       let after = self.view.subviews.count
                       
                       //If a bird was removed from superview
                       if (before != after) {
                           self.score += 1
                       }
                    
                       else if ballView.frame.intersects(friendly.frame){
                            let before = self.view.subviews.count
                            friendly.removeFromSuperview()
                            let after = self.view.subviews.count
                            
                            if before != after {
                            self.score -= 2 }
                            }
                        }
                    }
               }
           }
       }
    }

    // Initialise the crosshair image & starting position
    func setupShooter() {
       shooter.image = UIImage(named: "aim.png")
       shooter.frame = CGRect(x: W/27, y: H/2.5, width: 80, height: 80)
       shooter.isUserInteractionEnabled = true

       // Set the crosshair image to visible
       self.view.addSubview(shooter)
    }

    func addBirds() {
       let friendlyFrame = UIImageView(image: UIImage(named: "enemy.png"))
       friendlyFrame.frame = CGRect(x: W/1.2, y: H/2.5, width: 80, height: 80)
       birdViews.append(friendlyFrame)
       
       let friendlyFrame2 = UIImageView(image: UIImage(named: "enemy.png"))
       friendlyFrame2.frame = CGRect(x: W/1.2, y: H/1.4, width: 80, height: 80)
       birdViews.append(friendlyFrame2)
       
       let friendlyFrame3 = UIImageView(image: UIImage(named: "enemy.png"))
       friendlyFrame3.frame = CGRect(x: W/1.2, y: H/11, width: 80, height: 80)
       birdViews.append(friendlyFrame3)
    }
    
    func addFriendly() {
       let birdFrame = UIImageView(image: UIImage(named: "Jelly.png"))
       birdFrame.frame = CGRect(x: W/1.2, y: H/2.5, width: 90, height: 90)
       friendlyViews.append(birdFrame)
       
       let birdFrame2 = UIImageView(image: UIImage(named: "Jelly2.png"))
       birdFrame2.frame = CGRect(x: W/1.2, y: H/1.4, width: 90, height: 90)
       friendlyViews.append(birdFrame2)
       
       let birdFrame3 = UIImageView(image: UIImage(named: "Jelly3.png"))
       birdFrame3.frame = CGRect(x: W/1.2, y: H/11, width: 90, height: 90)
       friendlyViews.append(birdFrame3)
    }

    @objc func game() {
       gameInt -= 1
       
       if gameInt == 0 {
           gameTimer.invalidate()
           gameInt = 30;
           Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.end), userInfo: nil, repeats: false)
       }
    }

    @objc func end() {
       
       let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame3")
               as! EndViewController3
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

        shooter.oneMoreDelegate = self
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        addFriendly()
        addBirds()
        setupShooter()
        
        rockObstacle.layer.cornerRadius = 20
        rockObstacle.layer.masksToBounds = true
        rockObstacle.frame = CGRect(x: W/2, y: H/2.1, width: 100, height: 100)
        
        let friendly = UIImageView(image: nil)
        friendly.image = UIImage(named: "rock9.png")
        friendly.frame = CGRect(x: W/1.2, y: H/11, width: 70, height: 70)

        // Background img
        let bg2View = UIImageView(image: nil)
        bg2View.image = UIImage(named: "bg.jpg")
        bg2View.frame = UIScreen.main.bounds
        self.view.addSubview(bg2View)
        self.view.sendSubviewToBack(bg2View)

        //Random bird appearance
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {_ in
            
            let randNum = Int.random(in: 0 ... 2)
            let index = Int.random(in: 0 ... 2)
            
            if randNum == 0 || randNum == 1 {
                self.view.addSubview(self.birdViews[index])
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
                    self.birdViews[index].removeFromSuperview() }
            } else {
                self.view.addSubview(self.friendlyViews[index])
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {_ in
                    self.friendlyViews[index].removeFromSuperview() }
                }
            }
        }
    }
