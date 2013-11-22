//
//  BouncyTransition.m
//  Transition
//
//  Created by Ricardo Sampayo on 21/11/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import "BouncyTransition.h"

@implementation BouncyTransition
- (NSTimeInterval) transitionDuration:(id)transitionContext
{
    return 1.0f;
}
- (void) animateTransition:(id)transitionContext
{
    UIViewController *presentado = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *presentador = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:presentado.view];

    
    CGRect fullFrame = [transitionContext initialFrameForViewController:presentador];
    CGFloat height = CGRectGetHeight(fullFrame);

    presentado.view.frame = CGRectMake(
                                 fullFrame.origin.x,
                                 height + 16,
                                 CGRectGetWidth(fullFrame),
                                 height
                                 );
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0 usingSpringWithDamping:0.5f
          initialSpringVelocity:0.6f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         presentado.view.frame = CGRectMake(20, 20, CGRectGetWidth(fullFrame) - 40, height - 40 );
                         
                     } completion:^(BOOL finished) {
                         
                         [transitionContext completeTransition:YES];
                         
                     }];
}
@end
