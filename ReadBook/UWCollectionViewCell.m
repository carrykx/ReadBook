//
//  UWWaterFlowViewCell.m
//  UnderWear
//
//  Created by Duke Douglas on 13-1-15.
//  Copyright (c) 2013年 Lewis. All rights reserved.
//

#import "UWCollectionViewCell.h"

#define MARGIN 4.0f

@implementation UWCollectionViewCell
@synthesize indexPath;
@synthesize object;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    self.object = nil;
    self.indexPath = nil;
    [super dealloc];
}

- (void)prepareToReuse
{
    
}

- (void)fillViewWithObject:(id)_object
{
    self.object = _object;
}


@end
