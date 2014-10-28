//
//  FLSearchViewController.h
//  FaceLink
//
//  Created by nirvawolf on 22/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLViewController.h"
@protocol FLSearchViewControllerDelegate;

@interface FLSearchViewController : FLViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) id<FLSearchViewControllerDelegate> delegate;

@end


@protocol FLSearchViewControllerDelegate <NSObject>

@required
- (void)searchViewControllerDidEndSearch:(FLSearchViewController *)searchController;
@end

