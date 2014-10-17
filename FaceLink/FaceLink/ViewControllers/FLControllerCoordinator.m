//
//  FLControllerCoordinator.m
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLControllerCoordinator.h"
#import "FLMainViewController.h"
#import <UIKit/UIKit.h>

@interface FLControllerCoordinator ()

@property (nonatomic,strong) UIViewController *activeViewController;

@end

@implementation FLControllerCoordinator

+ (instancetype)sharedInstance
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[FLControllerCoordinator alloc] initForSingleton];
    });
    
    return s_instance;
}

- (id)initForSingleton
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

@end
