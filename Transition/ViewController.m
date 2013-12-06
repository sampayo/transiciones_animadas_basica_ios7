//
//  ViewController.m
//  Transition
//
//  Created by Ricardo Sampayo on 21/11/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import "ViewController.h"

#import "BouncyTransition.h"
#import "DismissTransition.h"
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
    
	[self presentViewController:vc animated:YES completion:^{
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [vc.view addGestureRecognizer:gesture];
    }];
    

    
}

#pragma mark
- (void) handleGesture: (UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
            // Empieza el gestare
        case UIGestureRecognizerStateBegan: {
            // indicamos al sistema que existe una interacción
            self.interactive = YES;
            // Inndicamos al sistema que empiece a despedir el view
            [self dismissViewControllerAnimated:YES completion:^{
                //Una vez finalizado la despedida indicamos al sistema que se termino la iteración
                self.interactive = NO;
            }];
            
            break;
        }
            // Cambios del gesture
        case UIGestureRecognizerStateChanged:{
            //Obtenemos datos importantes de la vista como:
            // vista contenedora del gesture
            //Punto de translación
            //porcentaje de tranlacion con respecto a la altura en nuestro caso
            UIView *view = gesture.view.superview;
            CGPoint translation = [gesture translationInView:view];
            CGFloat percentTransitioned = (translation.y / (CGRectGetWidth(view.frame)));
            
            // Modificamos la transición con el porcentaje antes obtenido
            [self.myInteractiveTransition updateInteractiveTransition:-percentTransitioned];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            
            if (self.myInteractiveTransition.percentComplete > 0.25) {
                [self.myInteractiveTransition finishInteractiveTransition];
            }else{
                [self.myInteractiveTransition cancelInteractiveTransition];
            }
            
            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            [self.myInteractiveTransition cancelInteractiveTransition];
            
            break;
        }
        default:
            break;
    }
}
#pragma mark DelegateTransition
- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
	BouncyTransition *transition = [[BouncyTransition alloc] init];
	return transition;
    
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    DismissTransition *transition = [[DismissTransition alloc] init];
	return transition;
}
#pragma mark
- (id <UIViewControllerInteractiveTransitioning>) interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.interactive) {
        
        self.myInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        return self.myInteractiveTransition;
    }
    return nil;
}

@end
