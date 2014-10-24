//
//  FLUser.h
//  FaceLink
//
//  Created by exitingchen on 14/10/24.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLUser : NSObject

@property (nonatomic,readonly) NSString *username;
@property (nonatomic,copy) NSString *smallImageUrl;
@property (nonatomic,copy) NSString *bigImageUrl;


@end
