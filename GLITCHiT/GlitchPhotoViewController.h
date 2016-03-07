//
//  GlitchPhotoViewController.h
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-06.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideBaseViewController.h"

@interface GlitchPhotoViewController : SlideBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *glitchPanel;
@property (weak, nonatomic) IBOutlet UIImageView *glitchButton;
@property (weak, nonatomic) IBOutlet UIButton *shareUploadButton;

@end
