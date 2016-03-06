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
@property (nonatomic) AVCaptureVideoPreviewLayer *capturePreviewLayer;
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic) dispatch_queue_t sessionQueue;


- (IBAction)cameraButtonActivated:(id)sender;
- (AVCaptureDevice *)getDiviceWithType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position;
@end

