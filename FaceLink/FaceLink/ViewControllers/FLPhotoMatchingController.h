//
//  FLPhotoMatchingController.h
//  FaceLink
//
//  Created by nirvawolf on 19/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPhotoMatchingController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImage *useImage;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zodiacLabel;
@property (weak, nonatomic) IBOutlet UILabel *basicInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIView *userInfoContainerView;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *complainButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIView *headView;

@end
