//
//  ViewController.m
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-02-21.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super setCurrentView:@"MainCamera"];

    // Setup capture session
    if (self.captureSession == nil)
    {
        self.captureSession = [AVCaptureSession new];
    }
    
    // Set up camera preview layer.
    AVCaptureDevice *caputreDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!caputreDevice)
    {
        NSLog(@"Error: Capture device not initilized");
        abort();
    }
    
    NSError *error = nil;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:caputreDevice error:&error];
    if (error)
    {
        NSLog(@"Error: Failed to create device input %@", error);
        abort();
    }
    
    // Check caputure session can accept input
    if (![self.captureSession canAddInput:deviceInput])
    {
        NSLog(@"Error: Capture session can not accept input");
        abort();
    }
    
    // Set Input
    [self.captureSession addInput:deviceInput];
    
    // Configure Preview layer
    self.capturePreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.capturePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.capturePreviewLayer setFrame:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    
    // Add layer to view
    [self.imageView.layer addSublayer:self.capturePreviewLayer];
    
    // Start camera
    [self.captureSession startRunning];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonActivated:(id)sender {
}
@end
