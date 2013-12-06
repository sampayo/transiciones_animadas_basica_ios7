//
//  DismissTransition.m
//  Transition
//
//  Created by Ricardo Sampayo on 05/12/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import "DismissTransition.h"

@implementation DismissTransition
- (NSTimeInterval) transitionDuration:(id)transitionContext
{
    return 1.0f;
}
- (void) animateTransition:(id)transitionContext
{
    // ubicamos la vista que vamos a mover
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    // Ubicamos el tamanio del contexto
    __block CGRect presentedFrame = [transitionContext initialFrameForViewController:fromVC];
    
    //Arrancamos con nuestra animación
    [UIView animateKeyframesWithDuration:1.0f delay:0.0 options:0 animations:^{
        //Separamos la animación en dos
        //Una parte que levante la vista un poco
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            fromVC.view.frame = CGRectMake(
                                           presentedFrame.origin.x,
                                           -20,
                                           presentedFrame.size.width,
                                           presentedFrame.size.height
                                           );}];
        // la última parte que la deje caer haciéndola rotar unos grados
        [UIView  addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            
            presentedFrame.origin.y += CGRectGetHeight(presentedFrame) + 20;
            fromVC.view.frame = presentedFrame;
            fromVC.view.transform = CGAffineTransformMakeRotation(0.2);
        }];
    } completion:^(BOOL finished) {
        //Finalizamos la transición
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}
@end
