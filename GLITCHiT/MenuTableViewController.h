//
//  MenuTableViewController.h
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-04.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewController : UITableViewController <UITableViewDelegate>
@property (nonatomic, strong) MenuTableViewController *singleton;
@property (nonatomic, strong) NSString *currentView;

+ (MenuTableViewController *) getController;
+ (BOOL) isValid;
+ (void) setController:(MenuTableViewController *)controller;


@end


