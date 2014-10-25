//
//  FLUser.h
//  FaceLink
//
//  Created by exitingchen on 14/10/24.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FLUser : NSObject

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *headSmallUrl;
@property (nonatomic,copy) NSString *headBigUrl;
@property (nonatomic,copy) NSString *photoSmallUrl;
@property (nonatomic,copy) NSString *photoBigUrl;

-  (UIImage *)headSmallImage;

- (UIImage *)headBigImage;

- (UIImage *)photoSmall;

- (UIImage *)photoBig;

@end
