//
//  FMDatabase.h
//  DoubanFM
//
//  Created by exitingchen on 14/9/30.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDatabase : NSObject

+ (instancetype)database;


- (void)deleteObject:(id)target;
- (void)deleteObjects:(NSArray *)targets;


@end
