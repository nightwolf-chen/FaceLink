//
//  FLFaceView.h
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FLFaceViewType{
    FLFaceViewTypeBig,
    FLFaceViewTypeSmall
}FLFaceViewType;

@interface FLFaceView : UIButton

@property (nonatomic,copy) NSString *username;

+ (instancetype)faceViewWithType:(FLFaceViewType)type name:(NSString *)name;

@end
