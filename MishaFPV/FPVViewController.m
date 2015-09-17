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

@interface FPVViewController ()

@property (weak, nonatomic) IBOutlet ReplicatorView *replicatorView;
@property (weak, nonatomic) IBOutlet FOGMJPEGImageView *previewImageView;

@end

@implementation FPVViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.replicatorView.replicatorLayer.instanceCount = 2;
    [self.previewImageView startWithURL:[NSURL URLWithString:@"http://192.168.10.123:7060"]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.replicatorView.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.view.bounds.size.width / 2, 0, 0);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
