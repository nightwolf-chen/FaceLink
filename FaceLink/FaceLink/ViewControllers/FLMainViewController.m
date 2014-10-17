//
//  FLMainViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLMainViewController.h"
#import "FMMacros.h"
#import "KxMenu.h"
#import "FLRecentViewController.h"
#import "FLHotViewController.h"


NS_ENUM(NSInteger, FLButtonTag){
    FLButtonCamare,
    FLButtonRecent,
    FLButtonHot,
    FLButtonMenu
};

static const int kHeadHight = 40;
static const int kControlPannelHight = 45;
static const CGFloat kMenuLeftMargin = 15;
static const CGFloat kMenuButtonWidth = 30;

@interface FLMainViewController ()

@property (nonatomic,strong) UIView *statusbarContainer;
@property (nonatomic,strong) UIView *headViewContainer;
@property (nonatomic,strong) UIView *contentViewContainer;
@property (nonatomic,strong) UIView *controlPanelViewContainer;

@property (nonatomic,strong) UIViewController *recentController;
@property (nonatomic,strong) UIViewController *hotController;

@end

@implementation FLMainViewController
- (void)dealloc
{
    self.headViewContainer = nil;
    self.contentViewContainer = nil;
    self.controlPanelViewContainer = nil;
}

- (void)p_setupContainers
{
    self.statusbarContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBAR_HIGHT)];
    
    self.headViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HIGHT,SCREEN_WIDTH, kHeadHight)];
    
    CGFloat contentHight = SCREEN_HIGHT - STATUSBAR_HIGHT - kHeadHight - kControlPannelHight / 2.0f;
    self.contentViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, kHeadHight + STATUSBAR_HIGHT,SCREEN_WIDTH,contentHight)];
    
    self.controlPanelViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-kControlPannelHight, SCREEN_WIDTH, kControlPannelHight)];
    
    self.statusbarContainer.backgroundColor = [UIColor grayColor];
    self.headViewContainer.backgroundColor = [UIColor redColor];
    self.contentViewContainer.backgroundColor = [UIColor greenColor];
    self.controlPanelViewContainer.opaque = NO;
    
    [self.view addSubview:_statusbarContainer];
    [self.view addSubview:_headViewContainer];
    [self.view addSubview:_contentViewContainer];
    [self.view addSubview:_controlPanelViewContainer];
}

- (void)p_setControlLPanelView
{
    CGFloat cameraButtonLength = kControlPannelHight * 1.5;
    CGFloat sideButtonHight = kControlPannelHight * 0.80f;
    
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, cameraButtonLength, cameraButtonLength)];
    cameraButton.center = CGPointMake(SCREEN_WIDTH / 2.0f, kControlPannelHight / 2.0f);
    cameraButton.tag = FLButtonCamare;
    [cameraButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat recentButtonWidth = (SCREEN_WIDTH - cameraButtonLength) / 2.0f;
    UIButton *recentButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                        kControlPannelHight - sideButtonHight,
                                                                        (SCREEN_WIDTH - cameraButtonLength)/2.0f,
                                                                        sideButtonHight)];
    recentButton.tag = FLButtonRecent;
    [recentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *hotButton = [[UIButton alloc] initWithFrame:CGRectMake(cameraButtonLength+recentButtonWidth,
                                                                    kControlPannelHight - sideButtonHight,
                                                                    recentButtonWidth,
                                                                    sideButtonHight)];
    hotButton.tag = FLButtonHot;
    [hotButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cameraButton.backgroundColor = [UIColor blackColor];
    recentButton.backgroundColor = [UIColor grayColor];
    hotButton.backgroundColor = [UIColor grayColor];
    
    [_controlPanelViewContainer addSubview:cameraButton];
    [_controlPanelViewContainer addSubview:recentButton];
    [_controlPanelViewContainer addSubview:hotButton];
}

- (void)p_setupHeadView
{
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.2, 0, SCREEN_WIDTH*0.6, kHeadHight)];
    usernameLabel.text = @"咔咔";
    usernameLabel.textAlignment = NSTextAlignmentCenter;

    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kMenuLeftMargin - kMenuButtonWidth,
                                                                     (kHeadHight - kMenuButtonWidth) / 2.0f,
                                                                     kMenuButtonWidth,
                                                                     kMenuButtonWidth)];
    menuButton.tag = FLButtonMenu;
    menuButton.backgroundColor = [UIColor blackColor];
    [menuButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headViewContainer addSubview:menuButton];
    [_headViewContainer addSubview:usernameLabel];
}

- (void)p_setupViewControlls
{
    self.recentController = [[FLRecentViewController alloc] initWithNibName:nil bundle:nil];
    self.hotController = [[FLHotViewController alloc] initWithNibName:nil bundle:nil];
    
    [self addChildViewController:_recentController];
    [self addChildViewController:_hotController];
    
    [self p_activateViewController:_recentController];
}

- (void)p_activateViewController:(UIViewController *)viewController
{
    [viewController.view removeFromSuperview];
    viewController.view.frame = _contentViewContainer.bounds;
    [_contentViewContainer addSubview:viewController.view];
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
                           [self p_itemWithName:@"修改资料"],
                           [self p_itemWithName:@"更换头像"],
                           [self p_itemWithName:@"我的相册"],
                           [self p_itemWithName:@"聊天模式"],
                           ];
    
    KxMenuItem *firstItem = menuItems[0];
    firstItem.foreColor = [UIColor whiteColor];
    
    [KxMenu showMenuInView:self.view fromRect:targetView.frame menuItems:menuItems];
}

- (void)buttonClick:(id)sender
{
    UIButton *theButton = (UIButton *)sender;
    
    switch (theButton.tag) {
        case FLButtonCamare:
        {
            
        }
            break;
        case FLButtonRecent:
        {
            [self p_activateViewController:_recentController];
        }
            break;
        case FLButtonHot:
        {
            [self p_activateViewController:_hotController];
        }
            break;
         case FLButtonMenu:
        {
            [self p_showDropdownMenu:theButton];
        }
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupContainers];
    [self p_setControlLPanelView];
    [self p_setupHeadView];
    [self p_setupViewControlls];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
