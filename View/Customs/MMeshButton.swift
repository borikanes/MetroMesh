//
//  MMeshButton.swift
//  MetroMesh
//
//  Created by Oluwabori Oludemi on 1/25/16.
//  Copyright © 2016 Oluwabori Oludemi. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
class MMeshButton: UIButton {
    
    var buttonSpreadView = UIView()
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
    }
    
    func setUpButton(){
        self.backgroundColor = UIColor(red: 52.0/255.0, green: 64.0/255.0, blue: 150.0/255.0, alpha: 1.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches as Set<UITouch> {
            let location = touch.location(in: self)

            buttonSpreadView.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
            buttonSpreadView.center = location
            buttonSpreadView.layer.cornerRadius = 22.0
            buttonSpreadView.layer.zPosition = -1000
            buttonSpreadView.backgroundColor = UIColor(red: 186.0/255.0, green: 193.0/255.0, blue: 241.0/255.0, alpha: 0.09)
            addSubview(buttonSpreadView)
            UIView.animate(withDuration: 0.75, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                () -> Void in
                let (centerX, centerY) = (self.buttonSpreadView.center.x, self.buttonSpreadView.center.y)
                let scaleFactor = sqrt(pow(self.frame.size.width - centerX, 2.0) + pow(self.frame.size.height - centerY, 2.0))
                self.buttonSpreadView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
                }, completion: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.buttonSpreadView.transform = CGAffineTransform.identity
            }, completion: { (complete: Bool) in
                self.buttonSpreadView.removeFromSuperview()
        })
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.buttonSpreadView.transform = CGAffineTransform.identity
            }, completion: { (complete: Bool) in
                self.buttonSpreadView.removeFromSuperview()
        })
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
