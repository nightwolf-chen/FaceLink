//
//  FLCameraViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLCameraViewController.h"
#import "FMMacros.h"

static const int kHeadHight = 40;
static const int kControlPannelHight = 45;

static const CGFloat kCameraPreviewHight = 300;

@interface FLCameraViewController ()

@property (nonatomic,strong) UIImagePickerController *pickerController;

@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *statusContainer;
@property (nonatomic,strong) UIView *cameraPreviewContainer;
@property (nonatomic,strong) UIView *toolbarViewContainer;
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
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HIGHT, SCREEN_WIDTH, kHeadHight)];
    self.headView.backgroundColor = [UIColor  grayColor];
    
    self.cameraPreviewContainer = [[UIView alloc] initWithFrame:CGRectMake(0,STATUSBAR_HIGHT+kHeadHight, SCREEN_WIDTH, kCameraPreviewHight)];
    self.cameraPreviewContainer.backgroundColor = [UIColor blackColor];
    
    self.templateViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                          STATUSBAR_HIGHT+kHeadHight+kCameraPreviewHight,
                                                                          SCREEN_WIDTH,
                                                                          SCREEN_HIGHT-STATUSBAR_HIGHT-kHeadHight-kControlPannelHight-kCameraPreviewHight)];
    self.templateViewContainer.backgroundColor = [UIColor blueColor];
    
    self.toolbarViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT - kControlPannelHight, SCREEN_WIDTH, kControlPannelHight)];
    self.toolbarViewContainer.backgroundColor = [UIColor grayColor];
    
    
    [self.view addSubview:_statusContainer];
    [self.view addSubview:_headView];
    [self.view addSubview:_cameraPreviewContainer];
    [self.view addSubview:_templateViewContainer];
    [self.view addSubview:_toolbarViewContainer];
}

- (void)p_setupImagePciker
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
//    imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupContainners];
    [self p_setupImagePciker];
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
