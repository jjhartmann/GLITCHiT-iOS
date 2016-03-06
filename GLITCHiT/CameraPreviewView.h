//
//  CameraPreviewView.h
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-05.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface CameraPreviewView : UIView
@property (nonatomic) AVCaptureSession *session;
@end
