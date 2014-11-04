//
//  FLLikeMeViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLViewController.h"

@interface FLLikeMeViewController : FLViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSArray *users;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
