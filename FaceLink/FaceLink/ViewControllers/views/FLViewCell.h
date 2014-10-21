//
//  FLViewCell.h
//  FaceLink
//
//  Created by exitingchen on 14/10/21.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *heartButton;

@property (assign, nonatomic) BOOL like;
@end
