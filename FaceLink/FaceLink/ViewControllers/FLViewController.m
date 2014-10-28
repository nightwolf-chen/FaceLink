//
//  FLViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/28.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLViewController.h"

@interface FLViewController ()

@end

@implementation FLViewController

- (id)initWithRequestInfo:(NSDictionary *)info
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _requestInfo = info;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithRequestInfo:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserInfo];
}

- (void)loadUserInfo
{
    //Do nothing,you should get data from userinfo in this method.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
