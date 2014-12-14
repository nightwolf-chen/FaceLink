//
//  FLUploadManager.h
//  FaceLink
//
//  Created by nirvawolf on 14/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QNResponseInfo;

typedef void (^UploadCompleteBlock)(QNResponseInfo*,NSString*,NSDictionary*);

@interface FLUploadManager : NSObject

+ (instancetype)sharedManager;

- (void)upldateImage:(UIImage *)image
                 key:(NSString *)key
               token:(NSString *)token
          completion:(UploadCompleteBlock)block;

@end
