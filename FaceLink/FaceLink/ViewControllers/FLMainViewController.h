//
//  FLMainViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FLMainViewSubController{
    FLMainViewSubControllerHot,
    FLMainViewSubControllerRecent,
    FLMainViewSubControllerSearch
}FLMainViewSubController;

@interface FLMainViewController : UIViewController

- (void)activateController:(FLMainViewSubController)subController;
@end
