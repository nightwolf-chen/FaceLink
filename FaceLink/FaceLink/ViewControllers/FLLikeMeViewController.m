//
//  FLLikeMeViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLLikeMeViewController.h"
#import "FLControllerCoordinator.h"
#import "FMMacros.h"
#import "Globals.h"
#import "FLViewCell.h"

@interface FLLikeMeViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation FLLikeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headView.layer.cornerRadius = kRoundedCornerRaduis;
    _headView.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonClicked:(id)sender {
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
    //定义CustomCell的复用标识,这个就是刚才在CustomCell.xib中设置的那个Identifier,一定要相同,否则无法复用
    static NSString *identifier = @"MyTableViewCell";
    //根据复用标识查找TableView里是否有可复用的cell,有则返回给cell
    cell = (FLViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    //判断是否获取到复用cell,没有则从xib中初始化一个cell
    if (!cell) {
        //将Custom.xib中的所有对象载入
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FLViewCell" owner:nil options:nil];
        //第一个对象就是CustomCell了
        cell = [nib objectAtIndex:0];
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
    return 10;
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
