//
//  FLRecentViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLRecentViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;


@end
