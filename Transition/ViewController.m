//
//  ViewController.m
//  Transition
//
//  Created by Ricardo Sampayo on 21/11/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import "ViewController.h"

#import "BouncyTransition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
- (IBAction) activarTransicion:(id)sender
{
    UIViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetalleViewController"];

//    UIViewController *vc = [[UIViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
	
	vc.transitioningDelegate = self;
    
	[self presentViewController:vc animated:YES completion:nil];
}

#pragma mark DelegateTransition
- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
	BouncyTransition *transition = [[BouncyTransition alloc] init];
	return transition;
    
}

@end
