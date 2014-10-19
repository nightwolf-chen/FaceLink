//
//  FLCameraViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLCameraViewController.h"
#import "FMMacros.h"
#import "Globals.h"
#import "FLSingleOptionMenu.h"

NS_ENUM(NSInteger, FLCameraViewButtonTag){
    FLCameraViewButtonBack,
    FLCameraViewButtonMenu,
    FLCameraViewButtonCamera
};


static const CGFloat kCameraPreviewHight = 320;

static const CGFloat kTemplateWidth = 85;
static const CGFloat kTemplateHeight = 100;
static const CGFloat kTemplateGap = 15;
static const int kTemplateCount = 8;

static const CGFloat kBackButtonWidth = 32;
static const CGFloat kBackButtonHeight = 32;
static const CGFloat kMoreMenuButtonWidth = 32;
static const CGFloat kMoreMenuButtonHeight = 32;
static const CGFloat kHeadButtonsMarginHorizontal = 15;

static const CGFloat kSideArrowWidth = 30;
static const CGFloat kCloseTemplateButtonHeight = 30;
static const CGFloat kCloseTemplateButtonWidth = 50;


@interface FLCameraViewController ()

@property (nonatomic,strong) UIImagePickerController *pickerController;

@property (nonatomic,strong) UIView *headViewContainer;
@property (nonatomic,strong) UIView *statusContainer;
@property (nonatomic,strong) UIView *cameraPreviewContainer;
@property (nonatomic,strong) UIView *controlPanelViewContainer;
@property (nonatomic,strong) UIView *templateViewContainer;

@end

@implementation FLCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)p_setupContainners
{
    self.statusContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STATUSBAR_HIGHT)];
    self.statusContainer.backgroundColor = [UIColor grayColor];
    
    self.headViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HIGHT, SCREEN_WIDTH, kHeadHight)];
    self.headViewContainer.backgroundColor = [UIColor  grayColor];
    
    self.cameraPreviewContainer = [[UIView alloc] initWithFrame:CGRectMake(0,STATUSBAR_HIGHT+kHeadHight, SCREEN_WIDTH, kCameraPreviewHight)];
    self.cameraPreviewContainer.backgroundColor = [UIColor blackColor];
    
    self.templateViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                          STATUSBAR_HIGHT+kHeadHight+kCameraPreviewHight,
                                                                          SCREEN_WIDTH,
                                                                          SCREEN_HIGHT-STATUSBAR_HIGHT-kHeadHight-kControlPannelHight/2.0f-kCameraPreviewHight)];
    self.templateViewContainer.backgroundColor = [UIColor blueColor];
    
    self.controlPanelViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT - kControlPannelHight, SCREEN_WIDTH, kControlPannelHight)];
    self.controlPanelViewContainer.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:_statusContainer];
    [self.view addSubview:_headViewContainer];
    [self.view addSubview:_cameraPreviewContainer];
    [self.view addSubview:_templateViewContainer];
    [self.view addSubview:_controlPanelViewContainer];
}

- (void)p_setupImagePciker
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    
    UIView *controllerView = imagePickerController.view;
    
    controllerView.alpha = 0.0;
    controllerView.frame = _cameraPreviewContainer.bounds;
    imagePickerController.showsCameraControls=NO;
    
    [_cameraPreviewContainer addSubview:controllerView];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         controllerView.alpha = 1.0;
                     }
                     completion:nil
     ];
    
    self.pickerController = imagePickerController;
}

- (void)p_setupHeadView
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(kHeadButtonsMarginHorizontal,
                                                                     (_headViewContainer.frame.size.height - kBackButtonHeight)/2.0f,
                                                                     kBackButtonWidth,
                                                                     kBackButtonHeight)];
    backButton.tag = FLCameraViewButtonBack;
    backButton.backgroundColor = [UIColor blueColor];
    [backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kHeadButtonsMarginHorizontal-kMoreMenuButtonWidth,
                                                                     (_headViewContainer.frame.size.height - kMoreMenuButtonHeight)/2.0f,
                                                                     kMoreMenuButtonWidth,
                                                                     kMoreMenuButtonHeight)];
    menuButton.tag = FLCameraViewButtonMenu;
    menuButton.backgroundColor = [UIColor blueColor];
    [menuButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headViewContainer addSubview:backButton];
    [_headViewContainer addSubview:menuButton];
}

- (void)p_setupTemplateView
{
    const int scrollViewHeight = kTemplateHeight + kTemplateGap;
    const int scrollViewWidth = SCREEN_WIDTH - kSideArrowWidth*2;
    CGRect scrollViewFrame = CGRectMake(kSideArrowWidth,
                                        kCloseTemplateButtonHeight,
                                        scrollViewWidth,
                                        scrollViewHeight);
    
    UIScrollView *templateScrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    templateScrollView.backgroundColor = [UIColor grayColor];
    CGSize contentSize = scrollViewFrame.size;
    contentSize.width = kTemplateGap * (kTemplateCount + 1) + kTemplateWidth * kTemplateCount;
    templateScrollView.contentSize = contentSize;
    templateScrollView.showsVerticalScrollIndicator = NO;
    templateScrollView.showsHorizontalScrollIndicator = YES;
    templateScrollView.clipsToBounds = YES;
    
    CGFloat startX = kTemplateGap;
    for(int i = 0 ; i < kTemplateCount ;i++){
        CGRect templateFrame = CGRectMake(startX + (kTemplateGap + kTemplateWidth)*i,
                                          (scrollViewFrame.size.height - kTemplateHeight)/2.0f,
                                          kTemplateWidth,
                                          kTemplateHeight);
        
        UIView *aTemplateView = [[UIView alloc] initWithFrame:templateFrame];
        aTemplateView.backgroundColor = [UIColor greenColor];
        [templateScrollView addSubview:aTemplateView];
    }
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-kCloseTemplateButtonWidth)/2.0f,
                                                                      0,
                                                                      kCloseTemplateButtonWidth,
                                                                      kCloseTemplateButtonHeight)];
    
    UIButton *leftArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           kSideArrowWidth,
                                                                           _templateViewContainer.frame.size.height)];
    
    UIButton *rightArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kSideArrowWidth,
                                                                            0,
                                                                            kSideArrowWidth,
                                                                            _templateViewContainer.frame.size.height)];
    
    closeButton.backgroundColor = [UIColor redColor];
    leftArrowButton.backgroundColor = [UIColor yellowColor];
    rightArrowButton.backgroundColor = [UIColor yellowColor];
    
    [_templateViewContainer addSubview:templateScrollView];
    [_templateViewContainer addSubview:closeButton];
    [_templateViewContainer addSubview:leftArrowButton];
    [_templateViewContainer addSubview:rightArrowButton];
}

- (void)p_setupControlPanelView
{
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - kCameraButtonWidth)/2.0f,
                                                                        0,
                                                                        kCameraButtonWidth,
                                                                        kCameraButtonHeight)];
    cameraButton.backgroundColor = [UIColor blackColor];
    
    [_controlPanelViewContainer addSubview:cameraButton];
}

- (void)p_showMenu:(UIView *)view
{
    [[[FLSingleOptionMenu alloc] init] showMenuInView:self.view fromRect:view.frame];
}

- (void)buttonClicked:(id)sender
{
    UIButton *theButton = (UIButton *)sender;
    
    switch (theButton.tag) {
        case FLCameraViewButtonBack:
        {
            [self dismissViewControllerAnimated:YES completion:^{}];
        }
            break;
        case FLCameraViewButtonMenu:
        {
            [self p_showMenu:theButton];
        }
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupContainners];
    [self p_setupImagePciker];
    [self p_setupTemplateView];
    [self p_setupHeadView];
    [self p_setupControlPanelView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
