//
//  CardsViewController.swift
//  Tinder CP Week 5 Lab
//
//  Created by Jess Lam on 3/2/16.
//  Copyright © 2016 Jess Lam. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageTransition: ImageTransition!
    

    @IBOutlet weak var selectedImageView: UIImageView!
    
    var imageOriginalCenter: CGPoint!
    var imageFinalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        imageFinalCenter = imageView.center
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panImage:")
        
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(panGestureRecognizer)
        
        imageTransition = ImageTransition()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func panImage(sender: UIPanGestureRecognizer) {
        
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            imageOriginalCenter = imageView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            var rotation = translation.x * 15 / 160
            
            imageView.center = CGPoint(x: imageOriginalCenter.x + translation.x, y: imageOriginalCenter.y + translation.y)
            
            
            if point.y < imageView.center.y {
                imageView.transform = CGAffineTransformMakeRotation(CGFloat(rotation * CGFloat(M_PI) / 180))
            } else {
                imageView.transform = CGAffineTransformMakeRotation(CGFloat(rotation * CGFloat(M_PI) / 180 * -1))
            }
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            //reverse order
            UIImageView.animateWithDuration(0.3, animations: { () -> Void in
                if translation.x > 50 {
                    self.imageView.center.x = 500
                } else if translation.x < -50 {
                    self.imageView.center.x = -500
                } else {
                    self.imageView.center = self.imageOriginalCenter
                    self.imageView.transform = CGAffineTransformIdentity
                    print("end")
                }
            })
        }
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        
        performSegueWithIdentifier("firstSegue", sender: self)
    }
    
    
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var profileViewController = segue.destinationViewController as! ProfileViewController
        
        profileViewController.image = self.imageView.image
        
        //do custom transition
        profileViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        profileViewController.transitioningDelegate = imageTransition
        
        
        profileViewController.view.layoutIfNeeded()
        
        //had to set .image
//        animalViewController.animalImageView.image = selectedImageView.image
        
        
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }

    
}
