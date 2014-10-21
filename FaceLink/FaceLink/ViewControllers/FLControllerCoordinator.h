//
//  FLControllerCoordinator.h
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FLControllerCoordinator : NSObject

@property (nonatomic,strong) UIViewController *mainViewController;

+ (instancetype)sharedInstance;

- (void)navigateTo:(UIViewController *)controller;
- (void)backToRoot;

@end
