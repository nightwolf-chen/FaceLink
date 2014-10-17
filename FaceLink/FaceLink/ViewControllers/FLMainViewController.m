//
//  FLMainViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLMainViewController.h"
#import "FMMacros.h"

static const int kHeadHight = 40;
static const int kControlPannelHight = 50;

@interface FLMainViewController ()

@property (nonatomic,strong) UIView *statusbarContainer;
@property (nonatomic,strong) UIView *headViewContainer;
@property (nonatomic,strong) UIView *contentViewContainer;
@property (nonatomic,strong) UIView *controlPanelViewContainer;

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
    
    self.statusbarContainer.backgroundColor = [UIColor blackColor];
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
    
    CGFloat recentButtonWidth = (SCREEN_WIDTH - cameraButtonLength) / 2.0f;
    UIButton *recentButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                        kControlPannelHight - sideButtonHight,
                                                                        (SCREEN_WIDTH - cameraButtonLength)/2.0f,
                                                                        sideButtonHight)];
    
    UIButton *hotButton = [[UIButton alloc] initWithFrame:CGRectMake(cameraButtonLength+recentButtonWidth,
                                                                    kControlPannelHight - sideButtonHight,
                                                                    recentButtonWidth,
                                                                    sideButtonHight)];
    
    cameraButton.backgroundColor = [UIColor blackColor];
    recentButton.backgroundColor = [UIColor grayColor];
    hotButton.backgroundColor = [UIColor grayColor];
    
    [_controlPanelViewContainer addSubview:cameraButton];
    [_controlPanelViewContainer addSubview:recentButton];
    [_controlPanelViewContainer addSubview:hotButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupContainers];
    [self p_setControlLPanelView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
