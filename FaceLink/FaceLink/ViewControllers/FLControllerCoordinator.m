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

@property (nonatomic,assign) UIViewController *activeViewController;

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

- (void)navigateTo:(UIViewController *)controller
{
    [self.mainViewController
     presentViewController:controller
     animated:YES
     completion:^{}];
    
    
    self.activeViewController = controller;
}

- (void)backToRoot
{
    if (_activeViewController && [_activeViewController respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [_activeViewController dismissViewControllerAnimated:YES completion:^{}];
    }
}


- (void)requestController:(FLViewControllerTag)controllerTag
{
    switch (controllerTag) {
        case FLViewControllerTagCamera:{
            
        }
            break;
            
        case FLViewControllerTagChat:{
        
        }
            break;
        case FLViewControllerTagILike:{
        
        }
            break;
        case FLViewControllerTagLikeMe:{
            
        }
            break;
        case FLViewControllerTagMain:{
        
        }
            break;
    }
}

@end
