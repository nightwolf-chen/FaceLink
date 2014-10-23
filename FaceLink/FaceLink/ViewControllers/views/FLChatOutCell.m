//
//  FLChatOutCell.m
//  FaceLink
//
//  Created by exitingchen on 14/10/21.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLChatOutCell.h"
#import "Globals.h"

@implementation FLChatOutCell

- (void)awakeFromNib {
    // Initialization code
    UIImage *image = [[UIImage imageNamed:@"bubble_out"] stretchableImageWithLeftCapWidth:kBubbleStretchableLeft
                                                                            topCapHeight:kBubbleStretchableTop];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = _bubbleBaseView.bounds;
    
    [_bubbleBaseView addSubview:imageView];
    
    [_bubbleBaseView bringSubviewToFront:_contentTextView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
