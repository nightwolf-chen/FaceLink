//
//  FLSearchViewController.h
//  FaceLink
//
//  Created by nirvawolf on 22/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLMainViewController.h"

@interface FLSearchViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic,assign) FLMainViewSubController searchCaller;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@end
