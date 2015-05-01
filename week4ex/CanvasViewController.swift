//
//  CanvasViewController.swift
//  week4ex
//
//  Created by Jim Cai on 4/30/15.
//  Copyright (c) 2015 com.codepath. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    var originalTrayCenter: CGPoint!
    var isUp = true
    var maxTrayHeightDown = CGFloat(700)
    var maxTrayHeightUp = CGFloat(500)
    

    var newlyCreatedFace: UIImageView!
    var newFaceOriginalCenter: CGPoint!

    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func onTrayPanGesture(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            originalTrayCenter = trayView.center
            
//            println("Gesture began at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Changed {
            var nextHeight = originalTrayCenter.y + translation.y
            if nextHeight > maxTrayHeightUp {

                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                        self.trayView.center = CGPoint(x: self.originalTrayCenter.x, y: nextHeight)
                    }, completion: { (finished: Bool) -> Void in
                })
            }else{
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                    self.trayView.center = CGPoint(x: self.originalTrayCenter.x, y: self.maxTrayHeightUp -
                        0.23*(self.maxTrayHeightUp-nextHeight))
                    }, completion: { (finished: Bool) -> Void in
                })
            }
          //  println("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            var velocity = sender.velocityInView(view)
            if velocity.y > 0 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                    self.trayView.center =  CGPoint(x: self.originalTrayCenter.x, y: self.maxTrayHeightDown)
                    }, completion: { (finished: Bool) -> Void in
                })
            } else {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                    self.trayView.center =  CGPoint(x: self.originalTrayCenter.x, y: self.maxTrayHeightUp)
                    }, completion: { (finished: Bool) -> Void in
                })
       
            }
        }
    }

    
    func onFacePinch(sender: UIPinchGestureRecognizer){
        if let view = sender.view {
            view.transform = CGAffineTransformScale(view.transform, sender.scale, sender.scale)
            sender.scale = 1
        }
    }

    
    
    @IBAction func onFacePanGesture(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {

            var imageView = sender.view as UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newFaceOriginalCenter = newlyCreatedFace.center
            let recognizer = UIPinchGestureRecognizer(target: self, action:"onFacePinch:")
            newlyCreatedFace.addGestureRecognizer(recognizer)
            newlyCreatedFace.userInteractionEnabled = true
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {

            newlyCreatedFace.center = CGPoint(x: newFaceOriginalCenter.x + translation.x, y: newFaceOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
