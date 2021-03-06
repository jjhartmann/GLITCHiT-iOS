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

#define TIMEOUT_USER_INTERACTION 6

@interface ViewController : SlideBaseViewController
// Idle Timer
@property NSTimer *idleTimer;

// UI Outlets
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButtonRing;
@property (weak, nonatomic) IBOutlet UIButton *switchCameraButton;
@property (weak, nonatomic) IBOutlet UIButton *flashButton;
@property (weak, nonatomic) IBOutlet UIButton *switchCameraButtonRing;
@property (weak, nonatomic) IBOutlet UIButton *flashButtonRing;


// Camera View
@property (nonatomic) AVCaptureVideoPreviewLayer *capturePreviewLayer;
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureDeviceInput *deviceInput;
@property (nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic) dispatch_queue_t sessionQueue;


// Scaling Properties
@property (nonatomic) CGFloat beginScale;
@property (nonatomic) CGFloat effectScale;

// UI Action Methods
- (IBAction)cameraButtonActivated:(id)sender;
- (IBAction)switchCameraActivited:(id)sender;
- (IBAction)flashButtonActivated:(id)sender;


// Camera Configuration Methods
- (AVCaptureDevice *)getDeviceWithType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position;
- (void)addObservers;
- (IBAction)respondToPinchGesture:(UIPinchGestureRecognizer *)sender;

// Timer method
- (void)resetIdleTimer;
- (void)idleTimerExceeded;
@end

