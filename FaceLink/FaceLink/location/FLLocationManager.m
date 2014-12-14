//
//  FLLocationManager.m
//  FaceLink
//
//  Created by nirvawolf on 13/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "FLLocationManager.h"

@interface FLLocationManager ()

@property (nonatomic,strong) NSMutableArray *callBacks;

@end

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
        
        _callBacks = [[NSMutableArray alloc] init];
    }

    return self;
}

- (void)startUpdateingLocation
{
    if ([_clManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_clManager requestWhenInUseAuthorization];
    }
    [_clManager startUpdatingLocation];
}

- (void)startUpdateingLocation:(FLLocationBlock)completionBlock
{
    [_callBacks addObject:completionBlock];
    [self startUpdateingLocation];
}

#pragma mark - CLLocationDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Did recieve location data");
    [self nofityCallBacks:YES location:locations.lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
    [self nofityCallBacks:NO location:nil];
}

- (void)nofityCallBacks:(BOOL)succ location:(id)location
{
    [_clManager stopUpdatingLocation];
    
    for(FLLocationBlock aBlock in _callBacks){
        aBlock(succ,location);
    }
    
    [_callBacks removeAllObjects];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    
}


@end
