//
//  AboutViewController.h
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-04.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutViewControllerDelegate <NSObject>

- (void)aboutViewDidFinish;

@end

@interface AboutViewController : UIViewController
@property (nonatomic, weak) id <AboutViewControllerDelegate> delegate;

- (IBAction)doneButtonPressed:(id)sender;

@end
