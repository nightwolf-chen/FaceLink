//
//  FLHTTPLoader.h
//  FaceLink
//
//  Created by nirvawolf on 14/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoaderCompletionBlock)(BOOL,id);

@interface FLHTTPLoader : NSObject

+ (instancetype)sharedLoader;

- (void)requestQNUploadToken:(NSDictionary *)userInfo
              completionBlock:(LoaderCompletionBlock)completBlock;

- (void)requestUserRegister:(NSDictionary *)parameters
                 completion:(LoaderCompletionBlock)block;

- (void)requestUserLogin:(NSDictionary *)parameters
              completion:(LoaderCompletionBlock)block;

@end
