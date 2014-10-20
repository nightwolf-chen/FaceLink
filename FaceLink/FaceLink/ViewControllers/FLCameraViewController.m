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
#import "FLPhotoMatchingController.h"

NS_ENUM(NSInteger, FLCameraViewButtonTag){
    FLCameraViewButtonBack,
    FLCameraViewButtonMenu,
    FLCameraViewButtonCamera,
    FLCameraViewButtonLeftArrow,
    FLCameraViewButtonRightArrow,
    FLCameraViewButtonCloseTemplate
};

NS_ENUM(NSInteger, FLScrollViewDirection){
        FLScrollViewDirectionLeft,
        FLScrollViewDirectionRight
};

typedef enum FLPhotoTemplateState{
    FLPhotoTemplateStateShowing,
    FLPhotoTemplateStateHidden
}FLPhotoTemplateState;


static const CGFloat kCameraPreviewHight = 320;

static const CGFloat kTemplateWidth = 68;
static const CGFloat kTemplateHeight = 68;
static const CGFloat kTemplateGap = 15;
static const int kTemplateCount = 8;

static const CGFloat kBackButtonWidth = 32;
static const CGFloat kBackButtonHeight = 32;
static const CGFloat kMoreMenuButtonWidth = 32;
static const CGFloat kMoreMenuButtonHeight = 32;
static const CGFloat kHeadButtonsMarginHorizontal = 15;

static const CGFloat kSideArrowWidth = 24;
static const CGFloat kCloseTemplateButtonHeight = 20;
static const CGFloat kCloseTemplateBtnIndicatorWidth = 40;
static const CGFloat kCloseTemplateBtnIndicatorHeight = 5;


@interface FLCameraViewController ()

@property (nonatomic,strong) UIImagePickerController *pickerController;

@property (nonatomic,strong) UIView *headViewContainer;
@property (nonatomic,strong) UIView *statusContainer;
@property (nonatomic,strong) UIView *cameraPreviewContainer;
@property (nonatomic,strong) UIView *controlPanelViewContainer;
@property (nonatomic,strong) UIView *templateViewContainer;

@property (nonatomic,assign) UIScrollView *templateScrollView;
@property (nonatomic,assign) CGRect templateScrollFrameOrigin;
@property (nonatomic,assign) FLPhotoTemplateState templateState;

@end

@implementation FLCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = RGB_UICOLOR(112, 196, 241);
    }
    return self;
}

- (void)p_setupContainners
{
    self.cameraPreviewContainer = [[UIView alloc] initWithFrame:CGRectMake(0,STATUSBAR_HIGHT+kHeadHight, SCREEN_WIDTH, kCameraPreviewHight)];
    self.cameraPreviewContainer.frame = CGRectMake(0, 18, SCREEN_WIDTH, SCREEN_HIGHT);
    
    self.statusContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STATUSBAR_HIGHT)];
    self.statusContainer.backgroundColor = RGB_UICOLOR(112, 196, 241);
    
    self.headViewContainer = [[UIView alloc] initWithFrame:CGRectMake(kHorizontalGap, STATUSBAR_HIGHT, SCREEN_WIDTH - 2*kHorizontalGap, kHeadHight)];
    self.headViewContainer.backgroundColor = RGB_UICOLOR(221, 244, 240);
    self.headViewContainer.layer.cornerRadius = kRoundedCornerRaduis;
    self.headViewContainer.layer.masksToBounds = YES;
    
    self.templateViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                          STATUSBAR_HIGHT+kHeadHight+kCameraPreviewHight,
                                                                          SCREEN_WIDTH,
                                                                          SCREEN_HIGHT-STATUSBAR_HIGHT-kHeadHight-kControlPannelHight-kCameraPreviewHight)];
    self.templateViewContainer.backgroundColor = RGB_UICOLOR(221, 244, 240);
    
    self.controlPanelViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT - kControlPannelHight, SCREEN_WIDTH, kControlPannelHight)];
    self.controlPanelViewContainer.backgroundColor = RGB_UICOLOR(49, 144, 168);
    
    
    [self.view addSubview:_cameraPreviewContainer];
    [self.view addSubview:_statusContainer];
    [self.view addSubview:_headViewContainer];
    [self.view addSubview:_templateViewContainer];
    [self.view addSubview:_controlPanelViewContainer];
}

- (void)p_setupImagePciker
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    
    UIView *controllerView = imagePickerController.view;
    CGRect frame = controllerView.frame;
    frame.origin.y = STATUSBAR_HIGHT+_headViewContainer.frame.size.height;
    controllerView.frame = frame;
    controllerView.alpha = 0.0;
    imagePickerController.showsCameraControls=NO;
    
    [_cameraPreviewContainer addSubview:controllerView];
    
    UIView *mask = [[UIView alloc] initWithFrame:_cameraPreviewContainer.bounds];
    mask.backgroundColor = [UIColor clearColor];
    mask.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *reconizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showTemplateArea:)];
    reconizer.direction = UISwipeGestureRecognizerDirectionUp;
    [mask addGestureRecognizer:reconizer];
    
    [_cameraPreviewContainer addSubview:mask];
    
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
    [menuButton setImage:[UIImage imageNamed:@"select_icon"] forState:UIControlStateNormal];
    [menuButton setImage:[UIImage imageNamed:@"select_icon"] forState:UIControlStateSelected];
    
    [menuButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, kHeadHight)];
    titleLabel.text = @"拍一下";
    titleLabel.center = CGPointMake((SCREEN_WIDTH - kHorizontalGap*2) / 2.0f, kHeadHight / 2.0f);
    
    [_headViewContainer addSubview:titleLabel];
    [_headViewContainer addSubview:backButton];
    [_headViewContainer addSubview:menuButton];
}

- (void)p_setupTemplateView
{
    const int whiteBorder = 6;
    
    const int scrollViewHeight = _templateViewContainer.frame.size.height - whiteBorder*2;
    const int scrollViewWidth = SCREEN_WIDTH - kSideArrowWidth*2 - whiteBorder*2;
    CGRect scrollViewFrame = CGRectMake(kSideArrowWidth + whiteBorder,
                                        whiteBorder,
                                        scrollViewWidth,
                                        scrollViewHeight);
    
    UIScrollView *templateScrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    templateScrollView.backgroundColor = RGB_UICOLOR(17, 96, 96);
    CGSize contentSize = scrollViewFrame.size;
    contentSize.width = kTemplateGap * (kTemplateCount + 1) + kTemplateWidth * kTemplateCount;
    templateScrollView.contentSize = contentSize;
    templateScrollView.showsVerticalScrollIndicator = NO;
    templateScrollView.showsHorizontalScrollIndicator = YES;
    templateScrollView.clipsToBounds = YES;
    
    self.templateScrollView = templateScrollView;
    
    CGFloat startX = kTemplateGap;
    for(int i = 0 ; i < kTemplateCount ;i++){
        CGRect templateFrame = CGRectMake(startX + (kTemplateGap + kTemplateWidth)*i,
                                          (scrollViewFrame.size.height - kTemplateHeight)/2.0f,
                                          kTemplateWidth,
                                          kTemplateHeight);
        
        UIImageView *aTemplateView = [[UIImageView alloc] initWithFrame:templateFrame];
        aTemplateView.layer.borderWidth = 2.0f;
        aTemplateView.layer.borderColor = [UIColor whiteColor].CGColor;
        aTemplateView.image = [UIImage imageNamed:@"pic_small"];
        [templateScrollView addSubview:aTemplateView];
    }
    
    UIButton *leftArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           kSideArrowWidth,
                                                                           _templateViewContainer.frame.size.height)];
    leftArrowButton.tag = FLCameraViewButtonLeftArrow;
    [leftArrowButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kSideArrowWidth,
                                                                            0,
                                                                            kSideArrowWidth,
                                                                            _templateViewContainer.frame.size.height)];
    rightArrowButton.tag = FLCameraViewButtonRightArrow;
    [rightArrowButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    leftArrowButton.backgroundColor = RGB_UICOLOR(229, 81, 115);
    rightArrowButton.backgroundColor = RGB_UICOLOR(229, 81, 115);
    
    
    CGRect templateControlFrame = _templateViewContainer.frame;
    templateControlFrame.origin.x = 0;
    templateControlFrame.origin.y -= kCloseTemplateButtonHeight;
    templateControlFrame.size.width = SCREEN_WIDTH;
    templateControlFrame.size.height = kCloseTemplateButtonHeight + _templateViewContainer.frame.size.height;
    UIView *templateControlView = [[UIView alloc] initWithFrame:templateControlFrame];
    
    [_templateViewContainer removeFromSuperview];
    CGRect tempNewFrame = _templateViewContainer.frame;
    tempNewFrame.origin.x = 0;
    tempNewFrame.origin.y = kCloseTemplateButtonHeight;
    _templateViewContainer.frame = tempNewFrame;
    
    [templateControlView addSubview:_templateViewContainer];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kCloseTemplateButtonHeight)];
    closeButton.tag = FLCameraViewButtonCloseTemplate;
    closeButton.backgroundColor = RGB_UICOLOR(49, 144, 168);
    UIView *closeIndicator = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     kCloseTemplateBtnIndicatorWidth,
                                                                     kCloseTemplateBtnIndicatorHeight)];
    closeIndicator.backgroundColor = RGB_UICOLOR(221, 244, 240);
    closeIndicator.center = CGPointMake(SCREEN_WIDTH/2.0f, kCloseTemplateButtonHeight/2.0f);
    [closeButton addSubview:closeIndicator];
    [closeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [templateControlView addSubview:closeButton];
    
    [_templateViewContainer addSubview:templateScrollView];
    [_templateViewContainer addSubview:leftArrowButton];
    [_templateViewContainer addSubview:rightArrowButton];
    
    [self.view addSubview:templateControlView];
    
    self.templateViewContainer = templateControlView;
    
    self.templateState = FLPhotoTemplateStateShowing;
    _templateViewContainer.alpha = 0.6;
}

- (void)p_setupControlPanelView
{
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - kCameraButtonWidth)/2.0f,
                                                                        0,
                                                                        kCameraButtonWidth,
                                                                        kCameraButtonHeight)];
    cameraButton.tag = FLCameraViewButtonCamera;
    [cameraButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cameraButton setImage:[UIImage imageNamed:@"camera_btn"] forState:UIControlStateSelected];
    [cameraButton setImage:[UIImage imageNamed:@"camera_btn"] forState:UIControlStateNormal];
    
    [_controlPanelViewContainer addSubview:cameraButton];
}

- (void)p_showMenu:(UIView *)view
{
    [[[FLSingleOptionMenu alloc] init] showMenuInView:self.view fromRect:view.frame];
}

- (void)p_scroll:(UIScrollView *)scrollView direction:(NSInteger)dir
{
    CGFloat step = kTemplateWidth;
    
    if (dir == FLScrollViewDirectionRight) {
        step *= -1;
    }
    
    CGPoint offset = scrollView.contentOffset;
    offset.x += step;
    
    if (offset.x > (scrollView.contentSize.width - scrollView.frame.size.width)) {
        offset.x = (scrollView.contentSize.width - scrollView.frame.size.width);
    }else if(offset.x < 0){
        offset.x = 0;
    }
    
    [scrollView setContentOffset:offset animated:YES];
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
        case FLCameraViewButtonCamera:
        {
            [_pickerController takePicture];
        }
            break;
        case FLCameraViewButtonCloseTemplate:
        {
            [self hideTemplateArea];
        }
            break;
        case FLCameraViewButtonLeftArrow:
        {
            [self p_scroll:_templateScrollView direction:FLScrollViewDirectionLeft];
        }
            break;
        case FLCameraViewButtonRightArrow:
        {
            [self p_scroll:_templateScrollView direction:FLScrollViewDirectionRight];
        }
            break;
            
    }
}

- (void)hideTemplateArea
{
    if (FLPhotoTemplateStateHidden == self.templateState) {
        return;
    }else{
        self.templateState = FLPhotoTemplateStateHidden;
    }
    
    self.templateScrollFrameOrigin = _templateViewContainer.frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _templateViewContainer.frame;
        frame.origin.y += SCREEN_HIGHT;
        _templateViewContainer.frame = frame;
    }];
}

- (void)showTemplateArea:(UIGestureRecognizer *)recognizer
{
    if (FLPhotoTemplateStateShowing == self.templateState) {
        return;
    }else{
        self.templateState = FLPhotoTemplateStateShowing;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _templateViewContainer.frame;
        frame.origin.y += SCREEN_HIGHT;
        _templateViewContainer.frame = _templateScrollFrameOrigin;
    }];
}

#pragma mark - imagepicker delegate 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originImage = info[UIImagePickerControllerOriginalImage];
    FLPhotoMatchingController *photoControl = [[FLPhotoMatchingController alloc] initWithNibName:nil bundle:nil];
    photoControl.useImage = originImage;
    
    [self presentViewController:photoControl animated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
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
