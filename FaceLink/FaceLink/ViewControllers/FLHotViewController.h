//
//  FLHotViewController.h
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLHotViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIView *myPhotoView;
@property (weak, nonatomic) IBOutlet UIImageView *myPhotoImageView;

@property (strong, nonatomic) NSArray *hotUsers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
