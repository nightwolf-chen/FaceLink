//
//  FLMainSubControllerDelegate.h
//  FaceLink
//
//  Created by exitingchen on 14/10/27.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//


@protocol FLMainSubControllerDelegate <NSObject>

@required

- (void)subControllerRequestSearch:(id)controller;

@end
