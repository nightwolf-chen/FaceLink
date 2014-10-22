//
//  FLHotViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLHotViewController.h"
#import "FMMacros.h"
#import "Globals.h"
#import "FLControllerCoordinator.h"
#import "FLLikeMeViewController.h"
#import "FLILikeViewController.h"

@interface FLHotViewController ()

@end

@implementation FLHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize contentSize = SCREEN_SIZE;
    contentSize.height *= 1.2f;
    _baseScrollView.contentSize = contentSize ;
    
    _headerView.layer.cornerRadius = kRoundedCornerRaduis;
    _headerView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchTextField resignFirstResponder];
}
- (IBAction)likeMeClicked:(id)sender {
    FLLikeMeViewController *controller = [[FLLikeMeViewController alloc] initWithNibName:nil bundle:nil];
    [[FLControllerCoordinator sharedInstance] navigateTo:controller];
}
- (IBAction)ILikeClicked:(id)sender {
    FLILikeViewController *controller = [[FLILikeViewController alloc] initWithNibName:nil bundle:nil];
    [[FLControllerCoordinator sharedInstance] navigateTo:controller];
}
- (IBAction)searchButtonClicked:(id)sender {
    [[FLControllerCoordinator sharedInstance] navigateWithinMain:FLMainViewSubControllerSearch caller:FLMainViewSubControllerHot];
}



@end
