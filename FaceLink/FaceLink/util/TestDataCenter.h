//
//  TestDataCenter.h
//  FaceLink
//
//  Created by exitingchen on 14/10/25.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLUser.h"

@interface TestDataCenter : NSObject

+  (FLUser *)currentUser;

+ (void)setCurrentUser:(FLUser *)aUser;

+ (NSArray *)hotUsers;

+ (NSArray *)recentChatFriends;

+ (NSArray *)allFriends;

+ (FLUser *)getMatchedUser;

@end
