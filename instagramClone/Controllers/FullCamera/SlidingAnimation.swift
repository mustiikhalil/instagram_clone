//
//  SlidingAnimation.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/21/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

protocol AnimationTypeProtocol {
    var isMain: Bool {get}
}

class SlidingAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private enum AnimationType {
        case dismiss, present
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        
        guard let toView = transitionContext.view(forKey: .to) else {return}
        guard let fromView = transitionContext.view(forKey: .from) else {return}
        containerView.addSubview(toView)
        // custom animation
        let animationType =  typeOfAnimation(ofViewController: transitionContext.viewController(forKey: .to) as! AnimationTypeProtocol)
        prepareAnimation(transitionContext: transitionContext, animation: Animation.setupAnimation(typeOfAnimation: animationType, toView: toView, fromView: fromView))
    }
    
    private func prepareAnimation(transitionContext: UIViewControllerContextTransitioning, animation: Animation) {
        animation.toView.frame = animation.toViewStartingFrame
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            animation.toView.frame = animation.toViewEndingFrame
            animation.fromView.frame = animation.fromViewEndingFrame
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func typeOfAnimation(ofViewController viewController: AnimationTypeProtocol) -> AnimationType {
        if !viewController.isMain {
            return .present
        }
        return .dismiss
    }
    
    private struct Animation {
        let toView: UIView
        let fromView: UIView
        let toViewStartingFrame: CGRect
        let toViewEndingFrame: CGRect
        let fromViewEndingFrame: CGRect
        
        static func setupAnimation(typeOfAnimation: AnimationType,toView: UIView, fromView: UIView) -> Animation {
            
            if typeOfAnimation == .present {
                
            let toViewStartingFrame = CGRect(x: -toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            let toViewEndingFrame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
            let fromViewEndingFrame = CGRect(x: fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height)
            let animation = Animation(toView: toView, fromView: fromView, toViewStartingFrame: toViewStartingFrame, toViewEndingFrame: toViewEndingFrame, fromViewEndingFrame: fromViewEndingFrame)
            return animation
            }
                else {
            
            let toViewStartingFrame = CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            let toViewEndingFrame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
            let fromViewEndingFrame = CGRect(x: -fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height)
            let animation = Animation(toView: toView, fromView: fromView, toViewStartingFrame: toViewStartingFrame, toViewEndingFrame: toViewEndingFrame, fromViewEndingFrame: fromViewEndingFrame)
            return animation
            }
        }
    }
}
