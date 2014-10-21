//
//  FLChatViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLChatViewController.h"
#import "FLControllerCoordinator.h"

@interface FLChatViewController ()

@end

@implementation FLChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonClicked:(id)sender {
    [[FLControllerCoordinator sharedInstance] backToRoot];
}

#pragma mark - UITableViewDelegate 




#pragma mark - UITableViewDataSource



@end
