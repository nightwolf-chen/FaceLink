//
//  FLChatViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/20.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLChatViewController.h"
#import "FLControllerCoordinator.h"
#import "FLChatInCell.h"
#import "FLChatOutCell.h"
#import "FLMessageModel.h"

@interface FLChatViewController ()

@property (nonatomic,strong) NSArray *msgModels;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;

@end

@implementation FLChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_chatTableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonClicked:(id)sender {
    [[FLControllerCoordinator sharedInstance] backToRoot];
}

- (void)setUsername:(NSString *)username
{
    _username = username;
    
    const int msgCount = 6;
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    NSArray *msgTexts = @[@"你好",@"你好呀",@"看了我的照片吗？",@"这个真的是你吗？",@"是滴呀~",@"约吗？"];
    
    for (int i = 0 ; i < msgCount; i++) {
        FLMessageModel *aModel = [[FLMessageModel alloc] init];
        aModel.content = msgTexts[i];
        aModel.msgType = i%2?FLMessageTypeIn:FLMessageTypeOut;
        aModel.username = _username;
        
        [tmpArray addObject:aModel];
    }
    
    self.msgModels = tmpArray;
    
    [_chatTableView reloadData];
    
}
#pragma mark - UITableViewDelegate 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _msgModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLChatInCell *cell;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FLChatInCell" owner:nil options:nil];
    //第一个对象就是CustomCell了
    cell = [nib objectAtIndex:0];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    //定义CustomCell的复用标识,这个就是刚才在CustomCell.xib中设置的那个Identifier,一定要相同,否则无法复用
    static NSString *identifier = @"ChatTableCell";
    //根据复用标识查找TableView里是否有可复用的cell,有则返回给cell
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //判断是否获取到复用cell,没有则从xib中初始化一个cell
    if (!cell) {
        
        FLMessageModel *model = _msgModels[indexPath.row];
        
        NSString *cellNibName = model.msgType == FLMessageTypeIn ? @"FLChatInCell" : @"FLChatOutCell";
        
        //将Custom.xib中的所有对象载入
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellNibName owner:nil options:nil];
        //第一个对象就是CustomCell了
        cell = [nib objectAtIndex:0];
        
        if (model.msgType == FLMessageTypeIn) {
            FLChatInCell *inCell = (FLChatInCell *)cell;
            inCell.contentTextView.text = model.content;
            inCell.nameLabel.text = model.username;
        }else{
            FLChatOutCell *outCell = (FLChatOutCell *)cell;
            outCell.contentTextView.text = model.content;
        }
        
    }
    
    return cell;
}




#pragma mark - UITableViewDataSource



@end
