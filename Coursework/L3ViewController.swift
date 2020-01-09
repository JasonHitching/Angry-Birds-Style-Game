//
//  L3ViewController.swift
//  Coursework
//
//  Created by Jason Hitching on 06/01/2020.
//  Copyright © 2020 Jason Hitching. All rights reserved.
//

import UIKit
import AVFoundation

protocol subview3Delegate {
    func fireBall()
    func updateCoord(X: Int, Y: Int)
}

class L3ViewController: UIViewController, subview3Delegate{
    
    @IBOutlet var shooter: DragImageView!
    
    //Global variables
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var birdSplat: AVAudioPlayer?
    
    var balls = [UIImageView]()
    var birdViews = [UIImageView]()
    var visibleBirds = [UIImageView]();
    var rockViews = [UIImageView]()
           
    var angleX:Int = 0
    var angleY:Int = 0
    var gameInt = 1
    var score = 0
    
    var birdTimer:Timer?
    var gameTimer = Timer()

    //Retrieve width & height of current phone screen
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    let rockObstacle2 = UIImageView(image: UIImage(named: "rock1"))
    let rockObstacle = UIImageView(image: UIImage(named: "rock8"))
    

    // Audio Configs
    
    /* Function to fire the ball from the shooter */
    func fireBall() {
       
       /* Create a new ball */
        let ballFrame = UIImageView(image: nil)
        ballFrame.image = UIImage(named: "ball.png")
        ballFrame.frame = CGRect(x: W/40, y: H/2.7, width: 50, height: 50)
        ballFrame.layer.cornerRadius = 20
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
       angleX = X
       angleY = Y
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
        collisionBehavior.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: rockObstacle2.frame))

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
                
                        self.score += 1
                   }
                }
            }
        }
    }
    
    
    func splat() {
        let path = Bundle.main.path(forResource:"EXPLOSION Bang 04.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            birdSplat = try AVAudioPlayer(contentsOf: url)
            birdSplat?.play()
        } catch {
            // BROKED
        }
    }

    func addGfx() {
        let enemyFrame = UIImageView(image: UIImage(named: "enemy.png"))
        enemyFrame.frame = CGRect(x: W/1.2, y: H/2.5, width: 60, height: 60)
        birdViews.append(enemyFrame)
        
        let enemyFrame2 = UIImageView(image: UIImage(named: "enemy.png"))
        enemyFrame2.frame = CGRect(x: W/1.2, y: H/1.4, width: 60, height: 60)
        birdViews.append(enemyFrame2)
       
        let enemyFrame3 = UIImageView(image: UIImage(named: "enemy.png"))
        enemyFrame3.frame = CGRect(x: W/1.2, y: H/11, width: 60, height: 60)
        birdViews.append(enemyFrame3)
        
        shooter.image = UIImage(named: "aim.png")
        shooter.frame = CGRect(x: W/27, y: H/2.5, width: 80, height: 80)
        shooter.isUserInteractionEnabled = true
        
        // Set the crosshair image to visible
        self.view.addSubview(shooter)
        
        // Background img
        let bg2View = UIImageView(image: nil)
        bg2View.image = UIImage(named: "BG3")
        bg2View.frame = UIScreen.main.bounds
        self.view.addSubview(bg2View)
        self.view.sendSubviewToBack(bg2View)
    }
    
    func addRocks() {
        
        rockObstacle.layer.cornerRadius = 20
        rockObstacle.layer.masksToBounds = true
        rockObstacle.frame = CGRect(x: W/2, y: H/1.2, width: 100, height: 100)
        self.view.addSubview(rockObstacle)
        
        rockObstacle2.frame = CGRect(x: W/2.5, y: H/30, width: 80, height: 80)
        self.view.addSubview(rockObstacle2)

    }
    
    @objc func game() {
        gameInt -= 1

       
       if gameInt == 0 {
           gameTimer.invalidate()
           gameInt = 20;
           Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.end), userInfo: nil, repeats: false)
       }
    }

    @objc func end() {
       balls.removeAll()
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

        shooter.oneMoreDelegate = self
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        startGameTimer()
        addGfx()
        addRocks()
        
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
