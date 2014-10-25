//
//  TestDataCenter.m
//  FaceLink
//
//  Created by exitingchen on 14/10/25.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "TestDataCenter.h"

static const int kUsersCount = 12;

static FLUser *s_currentUser;
static NSArray *s_allFriends;

@implementation TestDataCenter

+ (NSArray *)recentChatFriends
{
    const int recentCount = 9;
    NSArray *all = [self allFriends];
    return [all subarrayWithRange:NSMakeRange(0, recentCount)];
}

+ (NSArray *)hotUsers
{
    NSArray *all = [self allFriends];
    
    return [all subarrayWithRange:NSMakeRange(0, 4)];
}

+ (NSArray *)allFriends
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_allFriends = [self loadTestUsers];
    });
    
    return s_allFriends;
}

+ (NSArray *)loadTestUsers
{
    NSArray *names = @[@"angela",@"candy",@"jenifer",@"翠翠",@"亦碟",@"可儿",@"安雅",@"小玉",@"曼欣",@"甜妞妞",@"美嘉",@"菲心"];
    NSMutableArray *tmpUsers = [NSMutableArray array];
    
    for(int i = 1 ; i <= kUsersCount ; i++){
        NSString *indexStr = nil;
        
        if (i < 10) {
            indexStr = [NSString stringWithFormat:@"0%d",i];
        }else{
            indexStr = [NSString stringWithFormat:@"%d",i];
        }
        
        FLUser *aUser = [[FLUser alloc] init];
        
        aUser.username = names[i-1];
        aUser.headSmallUrl = [NSString stringWithFormat:@"head_small_%@",indexStr];
        aUser.headBigUrl = [NSString stringWithFormat:@"head_big_%@",indexStr];
        aUser.photoSmallUrl = [NSString stringWithFormat:@"photo_small_%@",indexStr];
        aUser.photoBigUrl = [NSString stringWithFormat:@"photo_big_%@",indexStr];
        
        [tmpUsers addObject:aUser];
    }
    
    return tmpUsers;
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

+ (NSArray *)iLikeFriends
{
    NSArray *all = [self allFriends];
    return [all subarrayWithRange:NSMakeRange(2,8)];
}

+ (NSArray *)likeMeFriends
{
    NSArray *all = [self allFriends];
    return [all subarrayWithRange:NSMakeRange(6,5)];
}


+ (FLUser *)findUserByName:(NSString *)username
{
    NSArray *all = [self allFriends];
    
    for(FLUser *aUser in all){
        if ([aUser.username isEqualToString:username] ||
            [aUser.username containsString:username]) {
            return aUser;
        }
    }
    
    return [[FLUser alloc] init];
}


+ (FLUser *)randomUser
{
    NSArray *all = [self allFriends];
    
    return all[(random()*100) % all.count];
}
@end
