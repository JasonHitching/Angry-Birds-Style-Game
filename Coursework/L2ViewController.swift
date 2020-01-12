//
//  L2ViewController.swift
//  Coursework
//
//  Created by Jason Hitching on 03/01/2020.
//  Copyright © 2020 Jason Hitching. All rights reserved.
//

import UIKit
import AVFoundation

protocol subview2Delegate {
    func fireBall()
    func updateCoord(X: Int, Y: Int)
}

class L2ViewController: UIViewController, subview2Delegate{

    @IBOutlet var shooter: DragImageView!
    @IBOutlet var squareBarrier: UIImageView!
 
   //Global variables
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    
    var birdSplat: AVAudioPlayer?
    var shooterWoosh: AVAudioPlayer?

    var balls = [UIImageView]();
    var birdViews = [UIImageView]();
    var visibleBirds = [UIImageView]();
    
    var angleX:Int = 0
    var angleY:Int = 0
    var birdTimer:Timer?
    var gameTimer = Timer()
    var gameInt = 12
    var score = 0
    
    //Retrieve width & height of current phone screen
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    /* Function to fire the ball from the shooter */
    func fireBall() {
        
        swipe()
        
        /* Create a new ball */
        let ballFrame = UIImageView(image: nil)
        ballFrame.image = UIImage(named: "rock9")
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
        
        collisionBehavior.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: squareBarrier.frame))

        
        /* BIRD COLLISIONS */
        collisionBehavior.action = {
            for ballView in self.balls {
                for bird in self.visibleBirds {
                    if ballView.frame.intersects(bird.frame) && bird.alpha != 0.0 {
                        
                        self.splat()
                        
                        // Remove intersected bird from visibleBirds array
                        let index = self.visibleBirds.firstIndex(of: bird)
                        self.visibleBirds.remove(at: index!)
                        
                        bird.removeFromSuperview()
                        
                        //If a bird was removed from superview
                        self.score += 1
//                        self.scoreLabel.text = "Score: " + String(self.score)
                    }
                }
            }
        }
    }
    
    func splat() {
        let path = Bundle.main.path(forResource:"SPLAT Crush 01.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            birdSplat = try AVAudioPlayer(contentsOf: url)
            birdSplat?.play()
        } catch {
            // BROKED
        }
    }
    
    func swipe() {
        let path = Bundle.main.path(forResource:"SWIPE Whoosh Double 01.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            shooterWoosh = try AVAudioPlayer(contentsOf: url)
            shooterWoosh?.play()
        } catch {
            // BROKED
        }
    }
    
    // Initialise the crosshair image & starting position
    func setupShooter() {
        shooter.image = UIImage(named: "shooter")
        shooter.frame = CGRect(x: W/27, y: H/2.5, width: 80, height: 80)
        shooter.isUserInteractionEnabled = true

        // Set the crosshair image to visible
        self.view.addSubview(shooter)
    }
    
    func addGfx() {
        let birdFrame = UIImageView(image: UIImage(named: "enemy.png"))
        birdFrame.frame = CGRect(x: W/1.2, y: H/2.5, width: 80, height: 80)
        birdViews.append(birdFrame)
        
        let birdFrame2 = UIImageView(image: UIImage(named: "enemy.png"))
        birdFrame2.frame = CGRect(x: W/1.2, y: H/1.4, width: 80, height: 80)
        birdViews.append(birdFrame2)
        
        let birdFrame3 = UIImageView(image: UIImage(named: "enemy.png"))
        birdFrame3.frame = CGRect(x: W/1.2, y: H/11, width: 80, height: 80)
        birdViews.append(birdFrame3)
        
        // Background img
        let bg2View = UIImageView(image: nil)
        bg2View.image = UIImage(named: "BG2")
        bg2View.frame = UIScreen.main.bounds
        self.view.addSubview(bg2View)
        self.view.sendSubviewToBack(bg2View)
        
        squareBarrier.layer.cornerRadius = 20
        squareBarrier.layer.masksToBounds = true
        squareBarrier.frame = CGRect(x: W/2, y: H/3, width: 100, height: 100)
        squareBarrier.layer.borderColor = UIColor.lightGray.cgColor
        squareBarrier.layer.borderWidth = 1.0
    }
    
    @objc func game() {
        gameInt -= 1
        
        if gameInt == 0 {
            gameTimer.invalidate()
            gameInt = 10;
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.end), userInfo: nil, repeats: false)
        }
    }
    
    @objc func end() {
        balls.removeAll()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame2")
                as! EndViewController2
        vc.scoreData = String(self.score)
        self.present(vc, animated: false, completion: nil)
        
    }
    
    func startGameTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.game), userInfo: nil, repeats: true)
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameTimer()
        score = 0

        shooter.anotherDelegate = self
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)

        addGfx()
        setupShooter()
     
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
