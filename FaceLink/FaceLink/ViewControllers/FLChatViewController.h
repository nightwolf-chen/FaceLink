//
//  FLChatViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSString *username;

@end
