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
#import "CameraPreviewView.h"

@interface ViewController : SlideBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
//@property (weak, nonatomic) IBOutlet CameraPreviewView *previewView;

// Camera View
@property (nonatomic) AVCaptureVideoPreviewLayer *capturePreviewLayer;
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureDeviceInput *deviceInput;
@property (nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic) dispatch_queue_t sessionQueue;


- (IBAction)cameraButtonActivated:(id)sender;
- (AVCaptureDevice *)getDeviceWithType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position;
- (void)addObservers;

@end

