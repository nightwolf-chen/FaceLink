//
//  FLHTTPLoader.m
//  FaceLink
//
//  Created by nirvawolf on 14/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLHTTPLoader.h"
#import <AFNetworking.h>

@interface FLHTTPLoader ()

@property (nonatomic,strong) AFHTTPRequestOperationManager *httpManager;

@end

@implementation FLHTTPLoader

+ (instancetype)sharedLoader
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] init];
    });
    
    return s_instance;
}

- (id)init
{
    if (self = [super init]) {
        _httpManager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void)requestQNUploadToken:(NSDictionary *)userInfo
              comletionBlock:(void (^)(BOOL, NSString *))completBlock
{
    NSString *const kJsonUrl = @"";
    
    NSDictionary *parameters = @{};
    
    [_httpManager GET:kJsonUrl parameters:parameters
              success:^(AFHTTPRequestOperation *op,id obj){
                  completBlock(YES,nil);
              }
              failure:^(AFHTTPRequestOperation *op,NSError *eror){
                  completBlock(NO,nil);
              }];
}



@end
