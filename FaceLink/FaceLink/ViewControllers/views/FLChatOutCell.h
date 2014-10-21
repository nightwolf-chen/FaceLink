//
//  FLChatOutCell.h
//  FaceLink
//
//  Created by exitingchen on 14/10/21.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLChatOutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end