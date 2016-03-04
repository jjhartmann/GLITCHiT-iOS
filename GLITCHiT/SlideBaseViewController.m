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
}

@end

@implementation SlideBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Setting up slide menu
    rootViewHeight = self.view.frame.size.height;
    rootViewWidth  = self.view.frame.size.width;
    menuHeight = rootViewHeight;
    menuWidth = (3*rootViewWidth)/4;
    
    [self setupSlideMenu];
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
    
}

- (void)showMenu:(BOOL)state
{
    
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
