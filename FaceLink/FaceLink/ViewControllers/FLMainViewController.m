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
#import "FLCameraViewController.h"
#import "Globals.h"
#import "FLSearchViewController.h"

#define CONTROL_BUTTON_COLOR RGB_UICOLOR(49, 144, 168)

NS_ENUM(NSInteger, FLButtonTag){
    FLButtonCamare,
    FLButtonRecent,
    FLButtonHot,
    FLButtonMenu
};



@interface FLMainViewController ()

@property (nonatomic,strong) UIView *statusbarContainer;
@property (nonatomic,strong) UIView *headViewContainer;
@property (nonatomic,strong) UIView *contentViewContainer;
@property (nonatomic,strong) UIView *controlPanelViewContainer;

@property (nonatomic,strong) UIViewController *recentController;
@property (nonatomic,strong) UIViewController *hotController;
@property (nonatomic,strong) UIViewController *searchController;

@property (nonatomic,assign) UIViewController *activeController;

@property (nonatomic,assign) UIButton *recentButton;
@property (nonatomic,assign) UIButton *hotButton;

@end

@implementation FLMainViewController
- (void)dealloc
{
    self.headViewContainer = nil;
    self.contentViewContainer = nil;
    self.controlPanelViewContainer = nil;
    self.statusbarContainer = nil;
    self.recentController = nil;
    self.hotController = nil;
}

- (void)p_setupContainers
{
    self.statusbarContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBAR_HIGHT)];
    
    CGFloat headViewWidth = SCREEN_WIDTH - 2*kHorizontalGap;
    self.headViewContainer = [[UIView alloc] initWithFrame:CGRectMake(kHorizontalGap, STATUSBAR_HIGHT,headViewWidth, kHeadHight)];
    self.headViewContainer.backgroundColor = CONTROL_BG_COLOR;
    self.headViewContainer.layer.cornerRadius = kRoundedCornerRaduis;
    self.headViewContainer.layer.masksToBounds = YES;
    
    CGFloat contentHight = SCREEN_HIGHT - STATUSBAR_HIGHT - kHeadHight - kControlPannelHight / 2.0f;
    self.contentViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, kHeadHight + STATUSBAR_HIGHT + kVerticalGap,SCREEN_WIDTH,contentHight)];
    
    self.controlPanelViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-kControlPannelHight, SCREEN_WIDTH, kControlPannelHight)];
    
    self.statusbarContainer.backgroundColor = MAIN_BG_COLOR;
    self.contentViewContainer.backgroundColor = CONTROL_BG_COLOR;
    
    [self.view addSubview:_statusbarContainer];
    [self.view addSubview:_headViewContainer];
    [self.view addSubview:_contentViewContainer];
    [self.view addSubview:_controlPanelViewContainer];
}

- (void)p_setControlLPanelView
{
    CGFloat sideButtonHight = kControlPannelHight * 0.8;
    
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kCameraButtonWidth, kCameraButtonHeight)];
    cameraButton.center = CGPointMake(SCREEN_WIDTH / 2.0f, kControlPannelHight / 2.0f);
    cameraButton.tag = FLButtonCamare;
    [cameraButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cameraButton setImage:[UIImage imageNamed:@"camera_btn"] forState:UIControlStateNormal];
    [cameraButton setImage:[UIImage imageNamed:@"camera_btn"] forState:UIControlStateSelected];
    
    CGFloat recentButtonWidth = (SCREEN_WIDTH - kCameraButtonWidth) / 2.0f;
    UIButton *recentButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                        kControlPannelHight - sideButtonHight,
                                                                        recentButtonWidth,
                                                                        sideButtonHight)];
    recentButton.tag = FLButtonRecent;
    [recentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [recentButton setImage:[UIImage imageNamed:@"recent_connect"] forState:UIControlStateSelected];
    [recentButton setImage:[UIImage imageNamed:@"recent_connect"] forState:UIControlStateNormal];
    
    UIButton *hotButton = [[UIButton alloc] initWithFrame:CGRectMake(kCameraButtonWidth+recentButtonWidth,
                                                                    kControlPannelHight - sideButtonHight,
                                                                    recentButtonWidth,
                                                                    sideButtonHight)];
    hotButton.tag = FLButtonHot;
    [hotButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [hotButton setImage:[UIImage imageNamed:@"predestine"] forState:UIControlStateNormal];
    [hotButton setImage:[UIImage imageNamed:@"predestine"] forState:UIControlStateSelected];
    
    
    recentButton.backgroundColor = CONTROL_BUTTON_COLOR;
    hotButton.backgroundColor = CONTROL_BUTTON_COLOR;
    
    self.recentButton = recentButton;
    self.hotButton = hotButton;
    
    [_controlPanelViewContainer addSubview:cameraButton];
    [_controlPanelViewContainer addSubview:recentButton];
    [_controlPanelViewContainer addSubview:hotButton];
}

- (void)p_setupHeadView
{
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.2, 0, SCREEN_WIDTH*0.6, kHeadHight)];
    usernameLabel.text = @"咔咔";
    
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    
//    UIImageView *kakaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kaka_word"]];
//    kakaImageView.center = CGPointMake(_headViewContainer.frame.size.width/2.0f, _headViewContainer.frame.size.height/2.0f);
//
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kMenuLeftMargin - kMenuButtonWidth,
                                                                     (kHeadHight - kMenuButtonWidth) / 2.0f,
                                                                     kMenuButtonWidth,
                                                                     kMenuButtonWidth)];
    menuButton.tag = FLButtonMenu;
    [menuButton setImage:[UIImage imageNamed:@"select_icon"] forState:UIControlStateNormal];
    [menuButton setImage:[UIImage imageNamed:@"select_icon"] forState:UIControlStateSelected];
    [menuButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headViewContainer addSubview:menuButton];
    [_headViewContainer addSubview:usernameLabel];
}

- (void)p_setupViewControlls
{
    self.recentController = [[FLRecentViewController alloc] initWithNibName:nil bundle:nil];
    self.hotController = [[FLHotViewController alloc] initWithNibName:nil bundle:nil];
    self.searchController = [[FLSearchViewController alloc] initWithNibName:nil bundle:nil];
    
    [self addChildViewController:_recentController];
    [self addChildViewController:_hotController];
    [self addChildViewController:_searchController];
    
    [self p_activateViewController:_recentController];
}

- (void)p_activateViewController:(UIViewController *)viewController
{
    if (viewController.view.superview) {
        [viewController.view removeFromSuperview];
    }
    
    if ([viewController isKindOfClass:[FLRecentViewController class]]) {
        _recentButton.backgroundColor = [UIColor darkGrayColor];
        if ([_activeController isKindOfClass:[FLHotViewController class]]) {
            _hotButton.backgroundColor = CONTROL_BUTTON_COLOR;
        }
        
    }else if([viewController isKindOfClass:[FLHotViewController class]]){
        _hotButton.backgroundColor = [UIColor darkGrayColor];
        if ([_activeController isKindOfClass:[FLRecentViewController class]]) {
            _recentButton.backgroundColor = CONTROL_BUTTON_COLOR;
        }
    }
    
    [_activeController.view removeFromSuperview];
    
    viewController.view.frame = _contentViewContainer.bounds;
    [_contentViewContainer addSubview:viewController.view];
    [_contentViewContainer bringSubviewToFront:_controlPanelViewContainer];
    [_contentViewContainer bringSubviewToFront:_headViewContainer];
    [_contentViewContainer bringSubviewToFront:_statusbarContainer];
    self.activeController = viewController;
    
}

- (void)activateController:(FLMainViewSubController)subController activater:(FLMainViewSubController)caller
{
    switch (subController) {
        case FLMainViewSubControllerHot:
            [self p_activateViewController:_hotController];
            break;
        case FLMainViewSubControllerRecent:
            [self p_activateViewController:_recentController];
            break;
        case FLMainViewSubControllerSearch:
        {
            ((FLSearchViewController *)_searchController).searchCaller = caller;
            [self p_activateViewController:_searchController];
        }
            break;
    }
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
    [KxMenu setTintColor:RGB_UICOLOR(228, 78, 108)];
}

- (void)buttonClick:(id)sender
{
    UIButton *theButton = (UIButton *)sender;
    
    switch (theButton.tag) {
        case FLButtonCamare:
        {
            UIViewController *ctr = [[FLCameraViewController alloc] initWithNibName:nil bundle:nil];
            [self presentViewController:ctr animated:YES completion:^{
            }];
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
    
    self.view.backgroundColor = MAIN_BG_COLOR;
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
