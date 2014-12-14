//
//  FLUploadManager.m
//  FaceLink
//
//  Created by nirvawolf on 14/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLUploadManager.h"
#import <QiniuSDK.h>


@interface FLUploadManager ()

@property (nonatomic,strong) QNUploadManager *qnUploadManager;

@end

@implementation FLUploadManager

+ (instancetype)sharedManager
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] _init];
    });
    
    return s_instance;
}

- (id)init
{
    NSAssert(NO, @"");
    return nil;
}

- (id)_init
{
    if (self = [super init]) {
        _qnUploadManager = [[QNUploadManager alloc] init];
    }
    
    return self;
}

- (void)upldateImage:(UIImage *)image
                 key:(NSString *)key
               token:(NSString *)token
            location:(CLLocation *)location
          completion:(UploadCompleteBlock)block
{
    static NSString *const kAppToken = @"x:app_token";
    static NSString *const kLatitude = @"x:latitude";
    static NSString *const kLongitude = @"x:longitude";
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSDictionary *parameters = @{kAppToken:token,
                                 kLatitude:@(location.coordinate.latitude),
                                 kLongitude:@(location.coordinate.longitude)};
    
    QNUploadOption *option = [[QNUploadOption alloc] initWithMime:@"application/octet-stream"
                                                  progressHandler:^(NSString *key,float percent){
                                                      
                                                  }
                                                           params:parameters
                                                         checkCrc:YES
                                               cancellationSignal:^BOOL(){
                                                   return YES;
                                               }];
    
    [_qnUploadManager putData:imageData
                          key:key
                        token:token
                     complete:block
                       option:option];
    
}

@end
