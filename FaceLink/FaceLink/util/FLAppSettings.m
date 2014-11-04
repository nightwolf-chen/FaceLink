//
//  FLAppSettings.m
//  FaceLink
//
//  Created by nirvawolf on 19/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLAppSettings.h"

static NSString *const kPrefix = @"FLAppSettings_";

static NSString *const kLedLight = @"kLedLight";
static NSString *const kUsername = @"kUsername";
static NSString *const kImageUrl = @"kImageUrl";

@interface FLAppSettings ()

@property (nonatomic,readonly,retain) NSString *userKey;

@end

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


+ (instancetype)infoWithUin:(NSString *)username
{
    return [[self.class alloc] initWithUsername:username];
}

- (id)initWithUsername:(NSString *)username
{
    if ( self = [super init] ) {
        _username  = username;
        _userKey = [NSString stringWithFormat:@"%@_%@",kPrefix,_username];
        
        //Register for default values.
        NSDictionary *infoDic = @{};
        
        NSDictionary *defaultValue = @{_userKey: infoDic};
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValue];
    }
    
    return self;
}

+ (BOOL)saveInfoToDisk
{
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)p_setObject:(id)obj forKey:(NSString *)key
{
    NSDictionary *info = [[NSUserDefaults standardUserDefaults] objectForKey:_userKey];
    NSMutableDictionary *mutableInfo = [info mutableCopy] ;
    mutableInfo[key] = obj;
    [[NSUserDefaults standardUserDefaults] setObject:mutableInfo forKey:_userKey];
}

- (id)p_objectForKey:(NSString *)key
{
    NSDictionary *info = [[NSUserDefaults standardUserDefaults] objectForKey:_userKey];
    return info[key];
}

#pragma mark - Getters and Setters
- (void)setUsername:(NSString *)username
{
    _username = username;
    [self p_setObject:username forKey:kUsername];
}

- (void)setImageUrl:(NSString *)imageUrl
{
    [self p_setObject:imageUrl forKey:kImageUrl];
}

- (NSString*)imageUrl
{
    return [self p_objectForKey:kImageUrl];
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
