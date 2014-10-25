//
//  FLFaceView.m
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLFaceView.h"
#import "FMMacros.h"
#import "TestDataCenter.h"
@implementation FLFaceView

+ (instancetype)faceViewWithType:(FLFaceViewType)type name:(NSString *)name
{
    return [[FLFaceView alloc] initWithType:type name:name];
}

- (id)initWithType:(FLFaceViewType)type name:(NSString *)name
{
    if (self = [super init]) {
        UIImageView *imageView = nil;
       
        _username = name;
        
        FLUser *currentUser = [TestDataCenter findUserByName:name];
        
        switch (type) {
            case FLFaceViewTypeBig:
            {
                imageView = [[UIImageView alloc] initWithImage:[currentUser headBigImage]];
            }
                break;
            case FLFaceViewTypeSmall:
            {
                imageView = [[UIImageView alloc] initWithImage:[currentUser headSmallImage]];
            }
                break;
        }
        
        [imageView.layer setBorderWidth:2];
        [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        CGFloat nameLabelW = 38;
        CGFloat nameLabelH = 25;
        CGRect nameFrame = CGRectMake(imageView.frame.size.width-nameLabelW,
                                      imageView.frame.size.height-nameLabelH,
                                      nameLabelW,
                                      nameLabelH);
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameFrame];
        nameLabel.text = name;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.backgroundColor = RGBA_UICOLOR(228, 78, 108,0.5);
        
        self.bounds = imageView.bounds;
        [imageView addSubview:nameLabel];
        [self addSubview:imageView];
    }
    
    return self;
}

@end
