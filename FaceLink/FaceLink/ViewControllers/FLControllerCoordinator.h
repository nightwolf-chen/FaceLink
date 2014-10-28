//
//  FLControllerCoordinator.h
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FLMainViewController.h"
#import "FLViewController.h"

typedef enum FLViewControllerTag{
    FLViewControllerTagMain=0,
    FLViewControllerTagCamera,
    FLViewControllerTagLikeMe,
    FLViewControllerTagILike,
    FLViewControllerTagChat,
    FLViewControllerTagCount
}FLViewControllerTag;

@interface FLControllerCoordinator : NSObject

@property (nonatomic,strong) FLViewController *mainViewController;

+ (instancetype)sharedInstance;

- (void)backToMain;

- (void)requestController:(FLViewControllerTag)controllerTag info:(NSDictionary *)userInfo;

@end
