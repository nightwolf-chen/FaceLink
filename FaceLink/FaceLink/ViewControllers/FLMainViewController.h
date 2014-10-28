//
//  FLMainViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLSearchViewController.h"
#import "FLMainSubControllerDelegate.h"
#import "FLViewController.h"

typedef enum FLMainViewSubController{
    FLMainViewSubControllerHot,
    FLMainViewSubControllerRecent,
    FLMainViewSubControllerSearch
}FLMainViewSubController;

@interface FLMainViewController : FLViewController<FLSearchViewControllerDelegate,FLMainSubControllerDelegate>

@end
