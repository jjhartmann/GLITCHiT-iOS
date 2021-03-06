//
//  MenuTableViewController.h
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-04.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"

// Delegate definition
@protocol MenuTableViewDelegate <NSObject>

- (void)finishedWithMenu;
- (void)menuItemIsSelected:(NSInteger)index;

@end


@interface MenuTableViewController : UITableViewController <UITableViewDelegate, AboutViewControllerDelegate>
@property (nonatomic, strong) MenuTableViewController *singleton;
@property (nonatomic, strong) NSString *currentView;
@property (nonatomic, weak) id <MenuTableViewDelegate> delegate;

+ (MenuTableViewController *) getController;
+ (BOOL) isValid;
+ (void) setController:(MenuTableViewController *)controller;

@end


