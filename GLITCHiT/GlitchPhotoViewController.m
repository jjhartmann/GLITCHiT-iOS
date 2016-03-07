//
//  GlitchPhotoViewController.m
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-06.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "GlitchPhotoViewController.h"

@interface GlitchPhotoViewController () {
    BOOL hasUIAnimated;
}
@end

@implementation GlitchPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setCurrentView:@"GlitchPhoto"];
    // Do any additional setup after loading the view.
    hasUIAnimated = NO;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!hasUIAnimated)
    {
        // Animate UI elements.
        CGRect ogpFrame = self.glitchPanel.frame;
        CGRect gpFrame = self.glitchPanel.frame;
        gpFrame.origin.y = 159.0;
        self.glitchPanel.frame = gpFrame;
        
        [UIView animateWithDuration:.75 animations:^(void){
            self.glitchPanel.frame = ogpFrame;
        }];
        
        
        
        // Set Glitch Btn to original position.
        CGRect ogbFrame = self.glitchButton.frame;
        CGRect gbFrame = CGRectMake(165, 47, 65, 65);
        self.glitchButton.frame = gbFrame;
        
        [UIView animateWithDuration:1.0 animations:^(void){
            self.glitchButton.frame = ogbFrame;
            self.glitchButton.transform = CGAffineTransformMakeRotation(360.0);
        }];
        
//        [UIView animateWithDuration:0.75 animations:^(void){
//            self.glitchButton.transform = CGAff(520.0);
//        }];
//        
        hasUIAnimated = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
