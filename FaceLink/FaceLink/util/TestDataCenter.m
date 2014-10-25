//
//  TestDataCenter.m
//  FaceLink
//
//  Created by exitingchen on 14/10/25.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "TestDataCenter.h"

static FLUser *s_currentUser;
static NSArray *s_allFriends;

@implementation TestDataCenter

+ (NSArray *)recentChatFriends
{
    return @[@"翠翠",@"阿花",@"阿花",@"阿花",@"阿美",@"阿花",@"阿花",@"阿花",@"阿花"];
}

+ (NSArray *)hotUsers
{
    return [NSArray array];
}

+ (NSArray *)allFriends
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_allFriends = [NSArray array];
    });
    
    return s_allFriends;
}

+ (FLUser *)currentUser
{
    return s_currentUser;
}

+ (void)setCurrentUser:(FLUser *)aUser
{
    s_currentUser = aUser;
}

+ (FLUser *)getMatchedUser
{
    NSArray *allFriends = [self allFriends];
    
    return allFriends[(random()*100)%allFriends.count];
}


@end
