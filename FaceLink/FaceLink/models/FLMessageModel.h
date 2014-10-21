//
//  FLMessageModel.h
//  FaceLink
//
//  Created by exitingchen on 14/10/21.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum FLMessageType{
    FLMessageTypeIn,
    FLMessageTypeOut
}FLMessageType;

@interface FLMessageModel : NSObject

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) FLMessageType msgType;

@end
