//
//  DragImageView.swift
//  Coursework
//
//  Created by Jason Hitching on 04/12/2019.
//  Copyright © 2019 Jason Hitching. All rights reserved.
//

import UIKit

class DragImageView: UIImageView {
    
    var myDelegate: subviewDelegate?
    var anotherDelegate: subview2Delegate?
    var oneMoreDelegate: subview3Delegate?
    
    var startLocation: CGPoint?
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startLocation = touches.first?.location(in: self)

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let  currentLocation = touches.first?.location(in: self)
            
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        var newCenter = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
            
        // Pass current shooter coordinates
        self.myDelegate?.updateCoord(X: Int(dx), Y: Int(dy))
        self.anotherDelegate?.updateCoord(X: Int(dx), Y: Int(dy))
        self.oneMoreDelegate?.updateCoord(X: Int(dx), Y: Int(dy))
    
        //Constrain movement to the phone screen bounds
        let halfx = self.bounds.midX // half the width of the image
        newCenter.x = max(self.bounds.width / 2, newCenter.x)
        newCenter.x = min(150 - halfx, newCenter.x)
        
        let halfy = self.bounds.midY;
        newCenter.y = max(self.superview!.bounds.height / 2 - 90 + halfy, newCenter.y)
        newCenter.y = min(self.superview!.bounds.height / 2 + 90 - halfy, newCenter.y)

        self.center = newCenter
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.center = CGPoint(x: UIScreen.main.bounds.width/10, y: UIScreen.main.bounds.height/2)
        
        self.anotherDelegate?.fireBall()
        self.myDelegate?.fireBall()
        self.oneMoreDelegate?.fireBall()
    }

}
