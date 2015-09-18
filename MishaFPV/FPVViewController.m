//
//  FPVViewController.m
//  MishaFPV
//
//  Created by Vitaly Berg on 17/09/15.
//  Copyright © 2015 Vitaly Berg. All rights reserved.
//

#import "FPVViewController.h"

#import "ReplicatorView.h"

#import <FOGMJPEGImageView/FOGMJPEGImageView.h>

#define FPV_URL @"http://192.168.10.123:7060"

@interface FPVViewController () <FOGMJPEGImageViewDelegate>

@property (weak, nonatomic) IBOutlet ReplicatorView *replicatorView;
@property (weak, nonatomic) IBOutlet FOGMJPEGImageView *previewImageView;

@property (strong, nonatomic) NSDate *lastFrameDate;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation FPVViewController

#pragma mark - Content

- (void)scheduleTimer {
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerRaised:) userInfo:nil repeats:YES];
}

- (void)timerRaised:(NSTimer *)timer {
    NSTimeInterval elapsed = [[NSDate date] timeIntervalSinceDate:self.lastFrameDate];
    if (elapsed > 3) {
        [self.previewImageView stop];
        [self.previewImageView startWithURL:[NSURL URLWithString:FPV_URL]];
    }
}

#pragma mark - FOGMJPEGImageViewDelegate

- (void)FOGMJPEGImageViewDidReceiveImage:(FOGMJPEGImageView *)mjpegImageView {
    self.lastFrameDate = [NSDate date];
}

- (void)FOGMJPEGImageView:(FOGMJPEGImageView *)mjpegImageView loadingImgaeDidFailWithError:(NSError *)error {
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.replicatorView.replicatorLayer.instanceCount = 2;
    self.previewImageView.delegate = self;
    self.lastFrameDate = [NSDate date];
    [self.previewImageView startWithURL:[NSURL URLWithString:FPV_URL]];
    [self scheduleTimer];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.replicatorView.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.view.bounds.size.width / 2, 0, 0);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
