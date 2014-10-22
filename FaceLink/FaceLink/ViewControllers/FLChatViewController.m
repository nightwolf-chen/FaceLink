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
#import "Globals.h"
#import "ProgressHUD.h"
#import "FMMacros.h"
#import "KxMenu.h"

typedef enum FLViewKeyboardState{
    FLViewKeyboardStateShowing,
    FLViewKeyboardStateHidden
}FLViewKeyboardState;


@interface FLChatViewController ()

@property (nonatomic,strong) NSMutableArray *msgModels;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (assign ,nonatomic) FLViewKeyboardState keyboardState;

@property (assign,nonatomic) CGRect textPanelOriginRect;
@property (assign,nonatomic) CGRect tableViewFrameRect;

@end

@implementation FLChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboradWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        _keyboardState = FLViewKeyboardStateHidden;
    }
    
    return self;
}

- (void)keyboradWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect kFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGRect newPanelFrame = _textPanelOriginRect;
                         newPanelFrame.origin.y -= kFrame.size.height;
                         _textPanelView.frame = newPanelFrame;
                         
                         CGRect newTableFrame = _tableViewFrameRect;
                         newTableFrame.size.height -= kFrame.size.height;
                         _chatTableView.frame = newTableFrame;
                         
                         
                         CGPoint offset = CGPointMake(0, _chatTableView.contentSize.height - _chatTableView.frame.size.height);
                         _chatTableView.contentOffset = offset;
                         
                     }
                     completion:^(BOOL finished){
                         
                         self.keyboardState = FLViewKeyboardStateShowing;
                     }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.2
                     animations:^{
                         _textPanelView.frame = _textPanelOriginRect;
                         _chatTableView.frame = _tableViewFrameRect;
                     }
                     completion:^(BOOL finished){
                         
                         self.keyboardState = FLViewKeyboardStateHidden;
                         CGPoint offset = CGPointMake(0, _chatTableView.contentSize.height - _chatTableView.frame.size.height);
                         _chatTableView.contentOffset = offset;
                     }];

}

- (void)scrollChatTableToBottom:(BOOL)animated
{
    CGPoint offset = CGPointMake(0, _chatTableView.contentSize.height - _chatTableView.frame.size.height);
    [_chatTableView setContentOffset:offset animated:animated];
}

- (void)appendMessage:(FLMessageModel *)msgModel
{
    [_msgModels addObject:msgModel];
    [_chatTableView reloadData];
    [self scrollChatTableToBottom:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textPanelOriginRect = _textPanelView.frame;
    self.tableViewFrameRect = _chatTableView.frame;
    
    [_chatTableView reloadData];
    
    _headView.layer.cornerRadius = kRoundedCornerRaduis;
    _headView.layer.masksToBounds = YES;
    
    UIView *tableBgView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_big"]];
    bgImgView.frame = tableBgView.bounds;
    bgImgView.contentMode = UIViewContentModeScaleToFill;
    [tableBgView addSubview:bgImgView];
    
    UIView *mastView = [[UIView alloc] initWithFrame:self.view.bounds];
    mastView.backgroundColor = RGBA_UICOLOR(96,146,161,0.5);
    [tableBgView addSubview:mastView];
    
    [self.view insertSubview:tableBgView belowSubview:_headView];
    [self.view bringSubviewToFront:_chatTableView];
    _chatTableView.backgroundColor = [UIColor clearColor];
    _chatTableView.backgroundView.backgroundColor = [UIColor clearColor];
    
    _nameLabel.text = _username;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollChatTableToBottom:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_textField resignFirstResponder];
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

    _nameLabel.text = _username;
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

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
            inCell.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
            inCell.headImageView.layer.borderWidth = 2;
        }else{
            FLChatOutCell *outCell = (FLChatOutCell *)cell;
            outCell.contentTextView.text = model.content;
            outCell.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
            outCell.headImageView.layer.borderWidth = 2;
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_textField.isFirstResponder) {
        [_textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.keyboardState ==  FLViewKeyboardStateShowing && [_textField isFirstResponder]) {
        [_textField resignFirstResponder];
    }
}

- (IBAction)sendButtonClicked:(id)sender {
    
    if (_textField.text == nil || [_textField.text isEqualToString:@""]) {
        [ProgressHUD showError:@"内容为空"];
        return;
    }
    
    FLMessageModel *model = [[FLMessageModel alloc] init];
    model.username = _username;
    model.msgType = FLMessageTypeOut;
    model.content = _textField.text;
    
    [self appendMessage:model];
    
    _textField.text = @"";
}
- (IBAction)menuButtonClicked:(id)sender {
    [self p_showDropdownMenu:((UIView *)sender)];
}

- (KxMenuItem *)p_itemWithName:(NSString *)name
{
    return [KxMenuItem menuItem:name
                          image:nil
                         target:nil
                         action:nil];
}

- (void)p_showDropdownMenu:(UIView *)targetView
{
    NSArray *menuItems = @[
                           [self p_itemWithName:@"备注"],
                           [self p_itemWithName:@"详细资料"],
                           [self p_itemWithName:@"删除此人"],
                           [self p_itemWithName:@"拉黑"],
                           ];
    
    KxMenuItem *firstItem = menuItems[0];
    firstItem.foreColor = [UIColor whiteColor];
    
    [KxMenu showMenuInView:self.view fromRect:targetView.frame menuItems:menuItems];
    [KxMenu setTintColor:RGB_UICOLOR(228, 78, 108)];
}
@end
