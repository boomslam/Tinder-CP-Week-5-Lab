//
//  ImageTransition.swift
//  Tinder CP Week 5 Lab
//
//  Created by Jess Lam on 3/2/16.
//  Copyright © 2016 Jess Lam. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    let movingImageView = UIImageView()
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let cardsViewController = fromViewController as! CardsViewController
        let profileViewController = toViewController as! ProfileViewController

        
        //cloning the view
        movingImageView.frame = cardsViewController.selectedImageView.frame
        movingImageView.image = cardsViewController.selectedImageView.image
        movingImageView.clipsToBounds = cardsViewController.selectedImageView.clipsToBounds
        movingImageView.contentMode = cardsViewController.selectedImageView.contentMode
        
        containerView.addSubview(movingImageView)
        
        cardsViewController.selectedImageView.alpha = 0
        
        profileViewController.imageView.alpha = 0
        toViewController.view.alpha = 0
        UIView.animateWithDuration(duration, animations: {
            toViewController.view.alpha = 1
            
            self.movingImageView.frame = profileViewController.imageView.frame
            
            //            //change frame to match frame of future image view
            //            farmViewController.selectedImageView.frame = animalViewController.animalImageView.frame
            
            }) { (finished: Bool) -> Void in
                profileViewController.imageView.alpha = 1
                cardsViewController.selectedImageView.alpha = 1
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        //        movingImageView.removeFromSuperview()
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            }) { (finished: Bool) -> Void in
                self.finish()
        }
    }
    
}
