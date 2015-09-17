//
//  ReplicatorView.m
//  MishaFPV
//
//  Created by Vitaly Berg on 16/08/15.
//  Copyright © 2015 Vitaly Berg. All rights reserved.
//

#import "ReplicatorView.h"

@implementation ReplicatorView

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (CAReplicatorLayer *)replicatorLayer {
    return (CAReplicatorLayer *)self.layer;
}

@end
