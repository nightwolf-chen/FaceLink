//
//  FLLocationManager.h
//  FaceLink
//
//  Created by nirvawolf on 13/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface FLLocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *clManager;

+ (instancetype)sharedManager;

- (void)startUpdateingLocation;

@end
