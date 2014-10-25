//
//  FLILikeViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLILikeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) NSArray *users;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
