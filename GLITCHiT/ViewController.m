//
//  ViewController.m
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-02-21.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "ViewController.h"

// Self Referencing static vars for context
static void *ContextSesssionRunning = &ContextSesssionRunning;
static void *ContextStillImageCaputuring = &ContextStillImageCaputuring;


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

#pragma mark -
#pragma Life Cycle

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
    
//    // Setup Preview Session
//    self.capturePreviewLayer.session = self.captureSession;
    
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
        
        // Setup capture device and inputs
        NSError *error;
        AVCaptureDevice *captureDevice = [self getDeviceWithType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        
        if (!deviceInput)
        {
            NSLog(@"Error: AVCaptureDeviceInput failed to initialize - %@", error);
        }
        
        // Begin Atomic device configuration
        [self.captureSession beginConfiguration];
        
        // Add device input
        if ([self.captureSession canAddInput:deviceInput])
        {
            [self.captureSession addInput:deviceInput];
            self.deviceInput = deviceInput;
            
            
            self.capturePreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
            self.capturePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            
            // Dispatch to main thread for UIView configuration
            dispatch_async(dispatch_get_main_queue(), ^(void){
                // set preview capture as sublayer
                [self.capturePreviewLayer setFrame:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];
                [self.imageView.layer addSublayer:self.capturePreviewLayer];
            });
        }
        else
        {
            NSLog(@"Capture Session Configuration Failed.");
            setupResult = AVCamSetupResultSessionConfigurationFailed;
        }
        
        // Setup still Image Capture Output
        AVCaptureStillImageOutput *stillImageOutput = [AVCaptureStillImageOutput new];
        if ([self.captureSession canAddOutput:stillImageOutput])
        {
            stillImageOutput.outputSettings = @{AVVideoCodecKey: AVVideoCodecJPEG};
            [self.captureSession addOutput:stillImageOutput];
            self.stillImageOutput = stillImageOutput;
        }
        
        // commit the configuration settings.
        [self.captureSession commitConfiguration];
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Dispatch to GCD
    dispatch_async(self.sessionQueue, ^(void)
    {
        switch (setupResult) {
            case AVCamSetupResultSuccess:
            {
                // Setup Observers
                [self addObservers];
                // Setup camera
                [self.captureSession startRunning];
                break;
            }
                
            default:
                NSLog(@"ERROR: Failed to setup the camera");
                // TODO: Display alert status.
                break;
        }
    
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (AVCaptureDevice *)getDeviceWithType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
    // Get array of avaliable devices from camera
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = devices.firstObject;
    
    
    // Search through devices to find desired camera
    for (AVCaptureDevice *d in devices)
    {
        if (d.position == position)
        {
            captureDevice = d;
            break;
        }
    }
    
    return captureDevice;
}

#pragma mark KVO Stuff
- (void)addObservers
{
    // Add observers on session and image capture
    [self.captureSession addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionNew context:ContextSesssionRunning];
    [self.stillImageOutput addObserver:self forKeyPath:@"capturingStillImage" options:NSKeyValueObservingOptionNew context:ContextStillImageCaputuring];
    
    // TODO: Add selectors Notification Center
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == ContextStillImageCaputuring)
    {
        // Flash the preview to indicate capture
        if ([change[NSKeyValueChangeNewKey] boolValue ])
        {
            dispatch_async(self.sessionQueue, ^(void){
                self.imageView.layer.opacity = 0.0;
                [UIView animateWithDuration:0.25 animations:^(void){
                    self.imageView.layer.opacity = 1.0;
                }];
            });
        }
    }
    else if (context == ContextSesssionRunning)
    {
        // TODO: Something when session running.
        // Freeze button.
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context ];
    }
}

#pragma mark -
#pragma mark UI Element Actions

- (IBAction)cameraButtonActivated:(id)sender {
}

- (IBAction)respondToPinchGesture:(UIPinchGestureRecognizer *)sender
{
    BOOL touchesAreOnImageView = YES;
    NSInteger numTouches = [sender numberOfTouches];
    for (NSInteger i = 0; i < numTouches; ++i)
    {
        CGPoint location = [sender locationOfTouch:i inView:self.imageView];
        CGPoint convertedLoc = [self.imageView convertPoint:location fromView:self.imageView.superview];
        
        if ([self.imageView.layer containsPoint:convertedLoc])
        {
            touchesAreOnImageView = NO;
            break;
        }
    }
    
    // If touches are in area, scale image and view.
    if (touchesAreOnImageView)
    {
        self.effectScale = self.beginScale * sender.scale;
        
        if (self.effectScale < 1.0)
            self.effectScale = 1.0;
        
        CGFloat maxCropFactor = [[self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        if (self.effectScale > maxCropFactor)
            self.effectScale = maxCropFactor;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.25];
        [self.imageView.layer setAffineTransform:CGAffineTransformMakeScale(self.effectScale, self.effectScale)];
        [CATransaction commit];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        self.beginScale = self.effectScale;
    }
    return YES;
}

@end
