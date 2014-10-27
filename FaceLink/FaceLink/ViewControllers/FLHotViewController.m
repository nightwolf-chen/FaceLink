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
#import "FLUser.h"
#import "TestDataCenter.h"
#import "FLChatViewController.h"
#import "FLMainViewController.h"

@interface FLHotViewController ()

@end

@implementation FLHotViewController

- (void)loadUsers
{
    self.hotUsers = [TestDataCenter hotUsers];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    _myPhotoImageView.image = [[TestDataCenter currentUser] photoSmall];
    
    [self loadUsers];
    
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
    if ([_delegate respondsToSelector:@selector(subControllerRequestSearch:)]) {
        [_delegate subControllerRequestSearch:self];
    }
}


#pragma mark - UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hotUsers.count + 2;
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
            
            
            NSInteger index = indexPath.row - 2;
            FLUser *userForCell = TYPE_CHANGE(FLUser *, _hotUsers[index]);
            
            FLViewCell *customCell = TYPE_CHANGE(FLViewCell *, cell);
            
            customCell.nameLabel.text = userForCell.username;
            customCell.headImageView.image = [userForCell headSmallImage];
            
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 1) {
        FLUser *aUser = _hotUsers[indexPath.row - 2];
        FLChatViewController *chatCtr = [[FLChatViewController alloc] initWithNibName:nil bundle:nil];
        chatCtr.username = aUser.username;
        [[FLControllerCoordinator sharedInstance] navigateTo:chatCtr];
    }
}



@end
