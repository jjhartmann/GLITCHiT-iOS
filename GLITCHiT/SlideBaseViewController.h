//
//  SlideBaseViewController.h
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-03.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideBaseViewController : UIViewController
                                    <UITableViewDelegate,
                                    UITableViewDataSource,
                                    UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSArray *menuItems;

- (void)setupSlideMenu;
- (void)showMenu:(BOOL)state gestureRecognizer:(UIPanGestureRecognizer *)recognizer;

@end

