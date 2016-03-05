//
//  ViewController.h
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-02-21.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SlideBaseViewController.h"

@interface ViewController : SlideBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

// Camera View
@property AVCaptureVideoPreviewLayer *capturePreviewLayer;
@property AVCaptureSession *captureSession;
@property AVCaptureVideoDataOutput *videoDataOutput;

- (IBAction)cameraButtonActivated:(id)sender;
@end

