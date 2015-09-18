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

#define LAG_TIME 2
#define FAIL_TIME 2

#define FPV_URL @"http://192.168.10.123:7060"

@interface FPVViewController () <FOGMJPEGImageViewDelegate>

@property (weak, nonatomic) IBOutlet ReplicatorView *replicatorView;
@property (weak, nonatomic) IBOutlet FOGMJPEGImageView *previewImageView;

@property (strong, nonatomic) NSTimer *lagTimer;
@property (strong, nonatomic) NSTimer *failTimer;

@end

@implementation FPVViewController

#pragma mark -

- (void)FOGMJPEGImageViewDidReceiveImage:(FOGMJPEGImageView *)mjpegImageView {
    [self.lagTimer invalidate];
    self.lagTimer = [NSTimer scheduledTimerWithTimeInterval:LAG_TIME target:self selector:@selector(lagRaised:) userInfo:nil repeats:NO];
}

- (void)FOGMJPEGImageView:(FOGMJPEGImageView *)mjpegImageView loadingImgaeDidFailWithError:(NSError *)error {
    [self.lagTimer invalidate];
    self.lagTimer = nil;
    [self.failTimer invalidate];
    self.failTimer = [NSTimer scheduledTimerWithTimeInterval:FAIL_TIME target:self selector:@selector(failRaised:) userInfo:nil repeats:NO];
}

#pragma mark - Content

- (void)lagRaised:(NSTimer *)timer {
    [self.previewImageView startWithURL:[NSURL URLWithString:FPV_URL]];
}

- (void)failRaised:(NSTimer *)timer {
    [self.previewImageView startWithURL:[NSURL URLWithString:FPV_URL]];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.replicatorView.replicatorLayer.instanceCount = 2;
    self.previewImageView.delegate = self;
    [self.previewImageView startWithURL:[NSURL URLWithString:FPV_URL]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.replicatorView.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.view.bounds.size.width / 2, 0, 0);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
