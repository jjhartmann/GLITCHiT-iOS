//
//  ViewController.m
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-02-21.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "ViewController.h"

// ENUM for camera status
typedef NS_ENUM( NSInteger, AVCamSetupResult ) {
    AVCamSetupResultSuccess,
    AVCamSetupResultCameraNotAuthorized,
    AVCamSetupResultSessionConfigurationFailed
};

@interface ViewController (){
    BOOL isUsingFrontCamera;
    AVCamSetupResult setupResult;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super setCurrentView:@"MainCamera"];
    isUsingFrontCamera = NO;
    
    // Setup capture session
    if (self.captureSession == nil)
    {
        self.captureSession = [AVCaptureSession new];
    }
    
    // Setup Preview Session
    self.capturePreviewLayer.session = self.captureSession;
    
    self.sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
    setupResult = AVCamSetupResultSuccess;
    
    // Check current authorization status
    switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]) {
        case AVAuthorizationStatusAuthorized:
            // Nothing
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            // Suspend session queue for now, wait until auithorization
            dispatch_suspend(self.sessionQueue);
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
                if (!granted)
                {
                    setupResult = AVCamSetupResultCameraNotAuthorized;
                }
                // Resume Session queue
                dispatch_resume(self.sessionQueue);
            }];
        }
        default:
            setupResult = AVCamSetupResultCameraNotAuthorized;
            break;
    }
    
    
    // Setup session through GCD
    dispatch_async(self.sessionQueue, ^(void){
        if (setupResult != AVCamSetupResultSuccess)
        {
            return; // Do not have permission to setup camera
        }
        
        NSError *error;
        
        
    
    });
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonActivated:(id)sender {
}
@end
