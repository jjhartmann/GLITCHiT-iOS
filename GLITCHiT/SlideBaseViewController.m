 //
//  SlideBaseViewController.m
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-03.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "SlideBaseViewController.h"

@interface SlideBaseViewController (){
    CGFloat menuWidth;
    CGFloat menuHeight;
    CGFloat rootViewWidth;
    CGFloat rootViewHeight;
    BOOL menuActive;
    BOOL menuShouldClose;
}

@end

@implementation SlideBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tag = 1;
    
    // Setting up slide menu
    rootViewHeight = self.view.frame.size.height;
    rootViewWidth  = self.view.frame.size.width;
    menuHeight = rootViewHeight;
    menuWidth = (3*rootViewWidth)/4;

    [self setupSlideMenu];
    
    // Create Gesture recognizer for pan
    UIScreenEdgePanGestureRecognizer *screenPanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(respondToSreenPanGesture:)];
    [screenPanRecognizer setMinimumNumberOfTouches:1];
    [screenPanRecognizer setMaximumNumberOfTouches:1];
    [screenPanRecognizer setEdges:UIRectEdgeLeft];
    
    [self.view addGestureRecognizer:screenPanRecognizer];
    
    // Create Gesture for removing menu
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPanGesture:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    
    [panGesture requireGestureRecognizerToFail:screenPanRecognizer];
    [self.view addGestureRecognizer:panGesture];
    menuActive = NO;
    menuShouldClose = NO;
    
    // Create tap gesture for dismissing view.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    
    [tapRecognizer requireGestureRecognizerToFail:screenPanRecognizer];
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Slide Menu Impelmentation
// Slide menu Methods

- (void)setupSlideMenu
{
    // Set up static table
    self.slideMenuView = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuTableSlideView"];

    //self.menuView = [[UIView alloc] initWithFrame:CGRectMake(-menuWidth, 0, menuWidth, menuHeight)];
    self.menuView = self.slideMenuView.view;
    self.menuView.frame = CGRectMake(-menuWidth, 0, menuWidth, menuHeight);
    [self.view addSubview:self.menuView];
    
    [self addChildViewController:self.slideMenuView];
    [self.slideMenuView didMoveToParentViewController:self];
}

- (void)showMenu:(BOOL)state gestureRecognizer:(UIGestureRecognizer *)recognizer
{
    // Get the location
    CGPoint location = [recognizer locationInView:self.view];
    
    CGRect frame = [self.menuView frame];
    frame.origin.x = -menuWidth + location.x;
    
    
    if (frame.origin.x <= 0)
        self.menuView.frame = frame;
    
    
    if ([recognizer state] == UIGestureRecognizerStateEnded  ||
        [recognizer state] == UIGestureRecognizerStateCancelled)
    {
        if ((state && location.x > menuWidth/3) ||
            (!state && location.x > menuWidth*2/3))
        {
            frame.origin.x =  0;
            menuActive = YES;
        }
        else
        {
            frame.origin.x = -(menuWidth + 5);
            menuActive = NO;
        }
        
        menuShouldClose = NO;
        
        // Animate the rest automatically
        [UIView animateWithDuration:0.6 animations:^{
            self.menuView.frame = frame;
        }];
    }
}

- (void)hideMenu:(UIGestureRecognizer *)recognizer
{
    menuShouldClose = NO;
    menuActive = NO;
    CGRect frame = [self.menuView frame];
    frame.origin.x = -(menuWidth + 5);
    
    // Animate the rest automatically
    [UIView animateWithDuration:0.6 animations:^{
        self.menuView.frame = frame;
    }];

}


#pragma mark -
#pragma mark Gesture Control Impl
- (void)respondToSreenPanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    if (!menuActive)
    {
        [self showMenu:YES gestureRecognizer:recognizer];
    }
}

- (void)respondToPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan)
    {
        UIView *view = [self.view hitTest:[recognizer locationInView:self.view] withEvent:Nil];
        menuShouldClose = (view == self.view);
    }
    
    if (menuActive && menuShouldClose)
    {
        [self showMenu:NO gestureRecognizer:recognizer];
    }
}

- (void)respondToTapGesture:(UITapGestureRecognizer *)recognizer
{
    UIView *view = [self.view hitTest:[recognizer locationInView:self.view] withEvent:Nil];
    if (menuActive && view == self.view)
    {
        [self hideMenu:recognizer];
    }
}


#pragma mark -
#pragma Gesture recognizer delegate impls
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self.view)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark -
#pragma mark Orientation Control
- (UIInterfaceOrientationMask) supportedInterfaceOrientations {

    return UIInterfaceOrientationMaskPortrait;

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
