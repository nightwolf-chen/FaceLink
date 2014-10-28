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
#import "FLMainViewController.h"
#import "FLCameraViewController.h"
#import "FLILikeViewController.h"
#import "FLLikeMeViewController.h"
#import "FLChatViewController.h"
#import "FMMacros.h"

@interface FLControllerCoordinator ()

@property (nonatomic,assign) UIViewController *activeViewController;
@property (nonatomic,strong) NSArray *viewControllerClass;

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
        _viewControllerClass = @[[FLMainViewController class],
                                 [FLCameraViewController class],
                                 [FLLikeMeViewController class],
                                 [FLILikeViewController class],
                                 [FLChatViewController class]
                                 ];
        
    }
    
    return self;
}

- (void)p_navigateTo:(UIViewController *)controller
{
    [self.mainViewController
     presentViewController:controller
     animated:YES
     completion:^{}];
    
    
    self.activeViewController = controller;
}

- (void)backToMain
{
    if (_activeViewController && [_activeViewController respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [_activeViewController dismissViewControllerAnimated:YES completion:^{}];
    }
}


- (void)requestController:(FLViewControllerTag)controllerTag info:(NSDictionary *)userInfo
{
    if (controllerTag == FLViewControllerTagMain || controllerTag >= FLViewControllerTagCount) {
        [self backToMain];
    }else{
        FLViewController *aController = [[TYPE_CHANGE(Class, _viewControllerClass[controllerTag]) alloc] initWithRequestInfo:userInfo];
        [self p_navigateTo:aController];
    }
}

@end
