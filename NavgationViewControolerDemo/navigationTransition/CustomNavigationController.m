//
//  CustomNavigationController.m
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/26.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import "CustomNavigationController.h"
#import "PopTransition.h"
#import "PopNavigationBarHiddenTransition.h"
#import "TransitionMacroHeader.h"
#import "PopWithNavigationBarTransition.h"

@interface CustomNavigationController()
@property (assign, nonatomic) BOOL interactive;
@property (strong, nonatomic) NSMutableSet *disableInteractiveClassSet;
@property (assign, nonatomic) NSUInteger didShowCount;
@end
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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    self.interactivePopGestureRecognizer.delegate = nil;
    [self.view removeGestureRecognizer:self.interactivePopGestureRecognizer];
    NSMutableArray *navigaionBars = [[NSMutableArray alloc] initWithCapacity:1];
    self.navigationBarArray = navigaionBars;
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
    self.interactivePopGesture = popRecognizer;
    popRecognizer.delegate = self;

    _disableInteractiveClassSet = [[NSMutableSet alloc] initWithCapacity:1];
    [_disableInteractiveClassSet addObject:@"WeatherViewController"];
    [_disableInteractiveClassSet addObject:@"PictureZoomController"];
}

#pragma mark - interactivePopGesture
- (void)handlePopRecognizer:(UIPanGestureRecognizer*)recognizer {

    if (_didShowCount < 2) {
        return;
    }
    _interactive = YES;
    
    CGPoint translationPoint = [recognizer translationInView:self.view];
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);

    BOOL panningRight = translationPoint.x > 0;
    
    if (!panningRight) {
        if ( [self.interactivePopTransition.transtion interactive] ) {
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
    if (progress > 0.5) {
        [self.interactivePopTransition finishInteractiveTransition];
        [self keepBalance:2];
    }
    else {
        [self.interactivePopTransition cancelInteractiveTransition];
        [self keepBalance:1];
    }
    NSLog(@"dealloc interactivePop");
    [self.interactivePopTransition.transtion finishOrCancelledTransition];
    self.interactivePopTransition = nil;
    self.interactive = NO;
}
- (void)keepBalance:(NSUInteger)count {
    for (int i=0; i < count; i++) {
        [self.navigationBarArray removeLastObject];
    }
}
#pragma mark - navigation delegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    if ( UINavigationControllerOperationPush == operation ) {
        UIView *view = nil;
        BOOL hidden = navigationController.navigationBarHidden;
        if ([NSStringFromClass(fromVC.class) isEqualToString:@"WeatherViewController"] ||
            [NSStringFromClass(fromVC.class) isEqualToString:@"RootLiveViewController"]) {
            view = [self navigationBarCopy];
        } else {
            view = [self navigationBarImageView];
        }

        view.hidden = hidden;
        [self.navigationBarArray addObject:view];
        return nil;
    }
    else {
        if ( !self.interactive ) {
            [self keepBalance:2];
            return nil;
        }
        if ( [NSStringFromClass(toVC.class) isEqualToString:@"ProfileViewController"] ) {
            if ( !_popNavigationBarHiddenTransition ){
                self.popNavigationBarHiddenTransition = [[PopNavigationBarHiddenTransition alloc] init];
            }
            [self.navigationBarArray addObject:[self navigationBarImageView]];
            if ( self.navigationBarArray.count > 1 ) {
                if ( self.popNavigationBarHiddenTransition ) {
                    self.popNavigationBarHiddenTransition.fromNavigationBar = self.navigationBarArray.lastObject;
                    self.popNavigationBarHiddenTransition.toNavigaionBar = self.navigationBarArray[self.navigationBarArray.count-2];
                }
            }
            return self.popNavigationBarHiddenTransition;
        }
        else if ( [NSStringFromClass(toVC.class) isEqualToString:@"WeatherViewController"] ||
                 [NSStringFromClass(toVC.class) isEqualToString:@"RootLiveViewController"]) {
            if (!_popWithNavigationBarTransition) {
                PopWithNavigationBarTransition *popTransition = [[PopWithNavigationBarTransition alloc] init];
                _popWithNavigationBarTransition = popTransition;
            }
            [self.navigationBarArray addObject:[self navigationBarImageView]];
            if ( self.navigationBarArray.count > 1 ) {
                if ( self.popWithNavigationBarTransition ) {
                    self.popWithNavigationBarTransition.fromNavigationBar = self.navigationBarArray.lastObject;
                    self.popWithNavigationBarTransition.toNavigaionBar = self.navigationBarArray[self.navigationBarArray.count-2];
                }
            }
            return self.popWithNavigationBarTransition;
        }
        else {
            if (!_popTransition) {
                PopTransition *popTransition = [[PopTransition alloc] init];
                self.popTransition = popTransition;
            }
            [self.navigationBarArray addObject:[self navigationBarImageView]];
            if ( self.navigationBarArray.count > 1 ) {
                if ( self.popTransition ) {
                    self.popTransition.fromNavigationBar = self.navigationBarArray.lastObject;
                    self.popTransition.toNavigaionBar = self.navigationBarArray[self.navigationBarArray.count-2];
                }
            }
            return self.popTransition;
        }
    }
}

- (UIImage *)snapshot:(UIView *)view
{
    CGRect frame = view.frame;
    frame.size.height = 64;
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
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
- (UIView *)navigationBarCopy {
    CGRect frame = self.navigationBar.bounds;
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    [self.navigationBar drawViewHierarchyInRect:frame afterScreenUpdates:NO];
    UIImage *navBar = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageNavBar = [[UIImageView alloc] initWithImage:navBar];
    imageNavBar.image = navBar;
    imageNavBar.frame = self.navigationBar.frame;
    return imageNavBar;
}
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    id<TransitionProtocol> transition = nil;
    if ( [animationController conformsToProtocol:@protocol(TransitionProtocol) ] ) {
        transition = (__bridge id<TransitionProtocol>)((__bridge void *) animationController);
    }
    self.interactivePopTransition.transtion = transition;
    return self.interactivePopTransition;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    MJUIViewController *baseVC = (MJUIViewController *) viewController;
//    [baseVC setBarAppearance];
    _didShowCount = navigationController.viewControllers.count;
    NSString *disableClass = NSStringFromClass(viewController.class);
    if ( [_disableInteractiveClassSet containsObject:disableClass] ) {
        self.interactivePopGesture.enabled = NO;
    }else {
        self.interactivePopGesture.enabled = YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ( [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class]) {
        [otherGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    }
    return YES;
}

@end

