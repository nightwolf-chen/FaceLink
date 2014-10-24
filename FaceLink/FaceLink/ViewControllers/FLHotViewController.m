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
#import "FLViewCell.h"

@interface FLHotViewController ()

@end

@implementation FLHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGSize contentSize = SCREEN_SIZE;
//    contentSize.height *= 1.2f;
//    _baseScrollView.contentSize = contentSize ;
    
    _headerView.layer.cornerRadius = kRoundedCornerRaduis;
    _headerView.layer.masksToBounds = YES;
    
    CGRect headFrame = _headerView.frame;
    headFrame.origin.x = kHorizontalGap;
    headFrame.origin.y = kVerticalGap;
    _headerView.frame = headFrame;
    
    CGRect photoFrame = _myPhotoView.frame;
    photoFrame.origin.x = kHorizontalGap;
    photoFrame.origin.y = kVerticalGap;
    _myPhotoView.frame = photoFrame;
    
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


#pragma mark - UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
   
    if (!cell) {
        if (indexPath.row == 0) {
            
            static NSString *identifier = @"HotViewTableHead";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.frame = _headerView.frame;
            cell.contentView.backgroundColor = RGB_UICOLOR(112, 196, 241);
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.contentView addSubview:_headerView];
            
        }else if(indexPath.row == 1){
            static NSString *identifier = @"HotViewTablePhoto";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.frame = _myPhotoView.frame;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = RGB_UICOLOR(112, 196, 241);
            [cell.contentView addSubview:_myPhotoView];
            
        }else{
            static NSString *identifier = @"HotViewTableCommon";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            //将Custom.xib中的所有对象载入
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FLViewCell" owner:nil options:nil];
            //第一个对象就是CustomCell了
            cell = [nib objectAtIndex:0];
        }
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return _headerView.frame.size.height + kVerticalGap * 2;
    }else if(indexPath.row == 1){
        return _myPhotoView.frame.size.height + kVerticalGap * 2;
    }else{
        FLViewCell *cell;
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FLViewCell" owner:nil options:nil];
        //第一个对象就是CustomCell了
        cell = [nib objectAtIndex:0];
        
        return cell.frame.size.height;
    }
}



@end
