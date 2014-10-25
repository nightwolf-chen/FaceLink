//
//  FLUser.m
//  FaceLink
//
//  Created by exitingchen on 14/10/24.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLUser.h"

@implementation FLUser

- (UIImage *)headSmallImage
{
    return [UIImage imageNamed:_headSmallUrl];
}

- (UIImage *)headBigImage
{
    return [UIImage imageNamed:_headBigUrl];
}

- (UIImage *)photoSmall
{
    return [UIImage imageNamed:_photoSmallUrl];
}

- (UIImage *)photoBig
{
    return [UIImage imageNamed:_photoBigUrl];
}

@end
