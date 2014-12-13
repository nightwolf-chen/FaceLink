//
//  FLLocationManager.m
//  FaceLink
//
//  Created by nirvawolf on 13/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "FLLocationManager.h"

@implementation FLLocationManager

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
    NSAssert(NO, @"use shared manager instead.");
    return nil;
}

- (id)_init
{
    if (self = [super init]) {
        _clManager = [[CLLocationManager alloc] init];
        _clManager.delegate = self;
        _clManager.desiredAccuracy = kCLLocationAccuracyBest;
    }

    return self;
}

- (void)startUpdateingLocation
{
 #ifdef DEBUG
    if ([_clManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_clManager requestWhenInUseAuthorization];
    }
    [_clManager startUpdatingLocation];
#endif
}

#pragma mark - CLLocationDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Did recieve location data");
    
    for(CLLocation *location in locations){
        NSLog(@"location:%f %f",location.coordinate.latitude,location.coordinate.longitude);
        [_clManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    
}


@end
