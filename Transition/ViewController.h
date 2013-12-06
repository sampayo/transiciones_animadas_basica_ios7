//
//  ViewController.h
//  Transition
//
//  Created by Ricardo Sampayo on 21/11/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController< UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *myInteractiveTransition;
@property (assign, nonatomic) BOOL interactive;
@end
