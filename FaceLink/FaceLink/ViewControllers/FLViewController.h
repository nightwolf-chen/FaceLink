//
//  FLViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/28.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLViewController : UIViewController

@property (nonatomic, strong) NSDictionary *requestInfo;

- (id)initWithRequestInfo:(NSDictionary *)info;


- (void)loadUserInfo;

@end
