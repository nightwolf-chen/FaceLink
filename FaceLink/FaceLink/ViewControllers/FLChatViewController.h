//
//  FLChatViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic,copy) NSString *username;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIView *textPanelView;
@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
