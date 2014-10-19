//
//  FLAppSettings.h
//  FaceLink
//
//  Created by nirvawolf on 19/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLAppSettings : NSObject

@property (nonatomic,assign) BOOL ledLight;


+ (instancetype)sharedSettings;

@end
