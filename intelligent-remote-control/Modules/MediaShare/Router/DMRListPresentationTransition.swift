//
//  DMRListPresentationTransition.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class DMRListPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.72
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! MediaShareDMRListViewController
        
        toVC.transitioningBackgroundView.backgroundColor = UIColor.darkGray
        toVC.transitioningBackgroundView.alpha = 0.0
        toVC.transitioningBackgroundView.frame = UIScreen.main.bounds
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.transitioningBackgroundView)
        containerView.addSubview(toVC.view)
        
        let toViewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        toVC.view.frame = toViewFrame
        
        let finalCenter = CGPoint(x: fromVC!.view.bounds.size.width / 2, y: UIScreen.main.bounds.height - toViewFrame.height/2)
        
        toVC.view.center = CGPoint(x: finalCenter.x, y:finalCenter.y + 1000)
        
        let options = UIViewAnimationOptions.curveEaseIn
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       delay: 0.0,
                       usingSpringWithDamping: 0.64,
                       initialSpringVelocity: 0.22,
                       options: options,
                       animations: {
                        toVC.view.center = finalCenter
                        toVC.transitioningBackgroundView.alpha = 0.7
        },
                       completion: { finished in
                        toVC.view.center = finalCenter
                        transitionContext.completeTransition(true)
        }
        )
    }
    
}
