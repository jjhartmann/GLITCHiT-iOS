//
//  SlideBaseViewController.h
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-03.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewController.h"

@interface SlideBaseViewController : UIViewController
                                    <UIGestureRecognizerDelegate, MenuTableViewDelegate>
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, weak) MenuTableViewController *slideMenuView;

- (void)setupSlideMenu;
- (void)showMenu:(BOOL)state gestureRecognizer:(UIGestureRecognizer *)recognizer;
- (void)hideMenu:(UIGestureRecognizer *)recognizer;
- (void)setCurrentView:(NSString *)cView;
@end

