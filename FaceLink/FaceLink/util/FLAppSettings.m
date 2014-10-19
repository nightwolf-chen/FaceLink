//
//  FLAppSettings.m
//  FaceLink
//
//  Created by nirvawolf on 19/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLAppSettings.h"

static NSString *const kLedLight = @"kLedLight";

@implementation FLAppSettings

+ (instancetype)sharedSettings
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[FLAppSettings alloc] init];
    });
    
    return s_instance;
}

- (BOOL)ledLight
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kLedLight];
}

- (void)setLedLight:(BOOL)ledLight
{
    [[NSUserDefaults standardUserDefaults] setBool:ledLight forKey:kLedLight];
}

@end
