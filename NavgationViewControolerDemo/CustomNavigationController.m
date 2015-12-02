//
//  CustomNavigationController.m
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/26.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import "CustomNavigationController.h"
#import "PushTransition.h"
#import "PopTransition.h"


@implementation CustomNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
//        self.navigationBar.backgroundColor = [UIColor yellowColor];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    self.interactivePopGestureRecognizer.delegate = nil;
//    self.navigationBar.translucent = NO;
    NSMutableArray *navigaionBars = [[NSMutableArray alloc] initWithCapacity:1];
    self.navigationBarArray = navigaionBars;
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
    self.interactivePopGesture = popRecognizer;
    popRecognizer.delegate = self;
}

#pragma mark - interactivePopGesture
- (void)handlePopRecognizer:(UIPanGestureRecognizer*)recognizer {
    if ( [self.navigationBarArray count] < 2) {
        return;
    }
    CGPoint translationPoint = [recognizer translationInView:self.view];
    NSLog(@"****%@",NSStringFromCGPoint(translationPoint));
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);

    BOOL panningRight = translationPoint.x > 0;
    
    if (!panningRight) {
        if ( [_popTransition interactive] ) {
            [self finishOrCancel:progress];
        }
        return;
    }
    progress = MIN(1.0, MAX(0.0, progress));
    // Calculate how far the user has dragged across the view
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        if ( !self.interactivePopTransition.interactive ) {
            self.interactivePopTransition = [[PopPercentDrivenInteractiveTransition alloc] init];
            [self popViewControllerAnimated:YES];
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        [self finishOrCancel:progress];
    }
}
- (void)finishOrCancel:(CGFloat)progress {
    // Finish or cancel the interactive transition
    self.interactivePopTransition.interactive = NO;
    if (progress > 0.5) {
        [self.interactivePopTransition finishInteractiveTransition];
    }
    else {
        [self.interactivePopTransition cancelInteractiveTransition];
    }
    self.popTransition.interactive = NO;
    NSLog(@"dealloc interactivePop");
    self.interactivePopTransition = nil;
    [self.popTransition finishOrCancelledTransition];
}
#pragma mark - navigation delegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    if ( UINavigationControllerOperationPush == operation ) {
        return nil;
//        return [[PushTransition alloc] init];
    }
    else {
        if (self.interactivePopTransition.interactive) {
            NSLog(@"interactivePopTransition.interactive");
            return nil;
        }
        if (!_popTransition) {
            PopTransition *popTransition = [[PopTransition alloc] init];
            self.popTransition = popTransition;
        }
        if ( self.navigationBarArray.count > 1 ) {
            if ( self.popTransition ) {
                self.popTransition.fromNavigationBar = self.navigationBarArray.lastObject;
                self.popTransition.toNavigaionBar = self.navigationBarArray[self.navigationBarArray.count-2];
            }
        }
        return self.popTransition;
    }
}
- (UIImage *)snapshot:(UIView *)view
{
    CGRect frame = view.frame;
    frame.size.height = 64;
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.frame afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (UIView *)navigationBarImageView {
    UIImage *navBar =[self snapshot:self.view];
    UIImageView *imageNavBar = [[UIImageView alloc] initWithImage:navBar];
    imageNavBar.image = navBar;
    imageNavBar.frame = CGRectOffset(imageNavBar.frame, 0, 0);
    return imageNavBar;
}
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactivePopTransition;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"viewcontrolelrs = %ld", [navigationController.viewControllers count]);
    NSUInteger count = navigationController.viewControllers.count;
    if ( count > self.navigationBarArray.count ) {
        UIView *view = [self navigationBarImageView];
        [self.navigationBarArray addObject:view];
    } else {
        [self.navigationBarArray removeLastObject];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ( [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class]) {
        [otherGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    }
    return YES;
}

@end

