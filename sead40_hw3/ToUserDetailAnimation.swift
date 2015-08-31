//
//  ToUserDetailAnimation.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/20/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class ToUserDetailAnimationController: NSObject {
  override init() {
    
  }
}

extension ToUserDetailAnimationController : UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserSearchViewController,
      toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? DetailViewController {
        let containerView = transitionContext.containerView()
        
        toVC.view.alpha = 0
        containerView.addSubview(toVC.view)
        
        let indexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
        let userCell = fromVC.collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewUserCell
        
        let snapShot = userCell.imageViewUser.snapshotViewAfterScreenUpdates(false)
        
        snapShot.frame = containerView.convertRect(userCell.imageViewUser.frame, fromCoordinateSpace: userCell.imageViewUser.superview!)
        
        containerView.addSubview(snapShot)
        userCell.hidden = true
        
        //ensure that my destination image view is in place
        toVC.view.layoutIfNeeded()
        
        toVC.imgViewDetail.hidden = true
        
        let destinationFrame = toVC.imgViewDetail.frame
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
          snapShot.frame = destinationFrame
          toVC.view.alpha = 1
          }, completion: { (finished) -> Void in
            userCell.hidden = false
            toVC.imgViewDetail.hidden = false
            snapShot.removeFromSuperview()
            if finished {
              transitionContext.completeTransition(finished)
            } else {
              transitionContext.completeTransition(finished)
            }
        })
        
    }
    
  }
  
  
}



