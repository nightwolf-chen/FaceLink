//
//  FLILikeViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLILikeViewController.h"
#import "FLControllerCoordinator.h"
#import "FLViewCell.h"
#import "FMMacros.h"
#import "FLUser.h"

@interface FLILikeViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation FLILikeViewController

- (void)loadUsers
{
    self.users = [NSArray array];
}

- (void)setUsers:(NSArray *)users
{
    _users = users;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonclicked:(id)sender {
    [[FLControllerCoordinator sharedInstance] backToRoot];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLViewCell *cell;
    static NSString *identifier = @"MyTableViewCell";
    cell = (FLViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        //将Custom.xib中的所有对象载入
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FLViewCell" owner:nil options:nil];
        //第一个对象就是CustomCell了
        cell = [nib objectAtIndex:0];
        
        NSInteger index = indexPath.row;
        cell.nameLabel.text = TYPE_CHANGE(FLUser *, _users[index]).username;
        NSString *imageUrl = TYPE_CHANGE(FLUser *, _users[index]).headSmallUrl;
        NSData *imageData = [NSData dataWithContentsOfFile:imageUrl];
        cell.headImageView.image = [UIImage imageWithData:imageData];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLViewCell *cell;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FLViewCell" owner:nil options:nil];
    //第一个对象就是CustomCell了
    cell = [nib objectAtIndex:0];
    
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _users.count;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLViewCell *cell = (FLViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.like) {
        [cell.heartButton setImage:nil forState:UIControlStateNormal];
        [cell.heartButton setImage:nil forState:UIControlStateSelected];
        cell.like = NO;
    }else{
        [cell.heartButton setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
        [cell.heartButton setImage:[UIImage imageNamed:@"save"] forState:UIControlStateSelected];
        cell.like = YES;
    }
}


@end
