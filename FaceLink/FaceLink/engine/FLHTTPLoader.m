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
             completionBlock:(LoaderCompletionBlock)completBlock
{
    static NSString *const kJsonUrl = @"http://face.zerojetlag.com/meets/upload_token";
    static NSString *const kAPPToken = @"app_token";
    
    NSDictionary *parameters = @{kAPPToken:@""};
    
    [_httpManager GET:kJsonUrl parameters:parameters
              success:^(AFHTTPRequestOperation *op,id obj){
                  completBlock(YES,obj);
              }
              failure:^(AFHTTPRequestOperation *op,NSError *eror){
                  completBlock(NO,nil);
              }];
}

- (void)requestUserLogin:(NSDictionary *)parameters
              completion:(LoaderCompletionBlock)block
{
    NSString *const loginUrl = @"http://face.zerojetlag.com/users/login";
}

- (void)requestUserRegister:(NSDictionary *)parameters
                 completion:(LoaderCompletionBlock)block
{
    NSString *const loginUrl = @"http://face.zerojetlag.com/users";
}


@end
