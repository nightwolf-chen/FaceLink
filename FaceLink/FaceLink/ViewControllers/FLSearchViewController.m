//
//  FLSearchViewController.m
//  FaceLink
//
//  Created by nirvawolf on 22/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLSearchViewController.h"
#import "FLViewCell.h"
#import "Globals.h"
#import "FLControllerCoordinator.h"
#import "FLUser.h"

@interface FLSearchViewController ()

@property (nonatomic,strong) NSArray *users;
@property (nonatomic,strong) NSArray *originUsers;

@end

@implementation FLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headView.layer.cornerRadius = kRoundedCornerRaduis;
    _headView.layer.masksToBounds = YES;
    
    [self contructTestData];
    
    [_searchTableView reloadData];
}

- (void)contructTestData
{
    NSArray *tmp = @[@"翠翠",@"小花",@"翠花",@"阿花",@"阿美",@"阿龙",@"阿肯",@"阿鬼",@"阿里"];
    self.originUsers = [tmp copy];
    self.users = [tmp copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_searchTextField becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchTextField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_searchTableView reloadData];
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
    
    FLUser *currentUser = _users[indexPath.row];
    cell.nameLabel.text = currentUser.username;
    cell.headImageView.image = [currentUser headSmallImage];
    
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
- (IBAction)cancleSearchClicked:(id)sender {
    [_searchTextField resignFirstResponder];
    _searchTextField.text = @"";
    
    [[FLControllerCoordinator sharedInstance] navigateWithinMain:_searchCaller caller:FLMainViewSubControllerSearch];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _users.count;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_searchTextField isFirstResponder]) {
        [_searchTextField resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)textChanged:(id)sender {
    
    NSString *key = ((UITextField *)sender).text;
    
    if (key != nil && ![key isEqualToString:@""]) {
        [self showSearchResults:key];
    }
    
}

- (void)showSearchResults:(NSString *)key
{
    self.users = [self searchForKey:key];
    [_searchTableView reloadData];
}

- (NSArray *)searchForKey:(NSString *)key
{
    NSMutableArray *tmp = [NSMutableArray array];
    
    for(FLUser *aUser in _originUsers){
        if ([aUser.username containsString:key]) {
            [tmp addObject:aUser];
        }
    }
    
    return tmp;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchTextField resignFirstResponder];
}

@end
