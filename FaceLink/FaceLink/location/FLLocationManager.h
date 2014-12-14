//
//  FLLocationManager.h
//  FaceLink
//
//  Created by nirvawolf on 13/12/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef  void (^FLLocationBlock)(BOOL , id);

@interface FLLocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *clManager;

+ (instancetype)sharedManager;

- (void)startUpdateingLocation:(FLLocationBlock)completionBlock;

@end
