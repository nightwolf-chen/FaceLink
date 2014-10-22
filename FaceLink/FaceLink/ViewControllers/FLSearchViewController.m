//
//  FLSearchViewController.m
//  FaceLink
//
//  Created by nirvawolf on 22/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLSearchViewController.h"
#import "FLViewCell.h"

@interface FLSearchViewController ()

@end

@implementation FLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 4;
}
@end
