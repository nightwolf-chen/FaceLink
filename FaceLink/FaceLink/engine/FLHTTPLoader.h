//
//  FLHTTPLoader.h
//  FaceLink
//
//  Created by nirvawolf on 14/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLHTTPLoader : NSObject

+ (instancetype)sharedLoader;

- (void)requestQNUploadToken:(NSDictionary *)userInfo
              comletionBlock:(void (^)(BOOL success,NSString *token))completBlock;

@end
