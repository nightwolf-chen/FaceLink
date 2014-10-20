//
//  FLPhotoMatchingController.m
//  FaceLink
//
//  Created by nirvawolf on 19/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLPhotoMatchingController.h"
#import "ProgressHUD.h"

static NSString *const kMatchingText = @"正在寻找同时拍照的人...";
static NSString *const kMatchingSuccessText = @"恭喜你们成功互换了照片";
static NSString *const kComplainSuccessText = @"已经举报该用户，谢谢反馈";

NS_ENUM(NSInteger, FLPhotoMatchingState){
    FLPhotoMatchingStateMatching,
    FLPhotoMatchingStateSuccess,
    FLPhotoMatchingStateFailed
};

@interface FLPhotoMatchingController ()

@property (nonatomic,assign) NSInteger matchingState;

@end

@implementation FLPhotoMatchingController

 - (id)initWithImage:(UIImage *)aImage
{
    if (self = [super init]) {
        _useImage = aImage;
    }
    
    return self;
}

- (void)setUseImage:(UIImage *)useImage
{
    _useImage = useImage;
    _userImageView.image = useImage;
    _userImageView.backgroundColor = [UIColor yellowColor];
}
- (IBAction)buttonClicked:(id)sender {
    if (_matchingState != FLPhotoMatchingStateMatching) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupUserImageView];
    [self p_hideViews:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self p_startMatching];
    });
}

- (void)p_setupUserImageView
{
    _userImageView.contentMode = UIViewContentModeScaleAspectFit;
    _userImageView.userInteractionEnabled = YES;
    _userImageView.image = _useImage;
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewSwiped:)];
    swipeRecognizer.delegate = self;
    swipeRecognizer.direction = (UISwipeGestureRecognizerDirectionDown |
                                 UISwipeGestureRecognizerDirectionUp |
                                 UISwipeGestureRecognizerDirectionLeft |
                                 UISwipeGestureRecognizerDirectionRight);
    
    [_userImageView addGestureRecognizer:swipeRecognizer];
}

- (void)imageViewSwiped:(UIGestureRecognizer *)recognizer
{
    if (_matchingState == FLPhotoMatchingStateSuccess) {
        [self p_startMatching];
    }
}

- (void)p_startMatching
{
    _userImageView.image = _useImage;
    
    self.matchingState = FLPhotoMatchingStateMatching;
    _statusLabel.text = kMatchingText;
    
    [self p_hideViews:YES];

    //show progress indicator
    [ProgressHUD show:kMatchingText];
    
    void (^matchingSuccessBlock)(void) = ^{
        
        [UIView animateWithDuration:0.5 animations:^{
            _userImageView.image = nil;
            _statusLabel.text = @"";
            self.view.layer.transform = CATransform3DMakeRotation(M_PI,0.0,2.0,0.0);
        } completion:^(BOOL finished){
            
            self.view.layer.transform = CATransform3DMakeRotation(M_PI,0.0,0.0,0.0);
            [self p_hideViews:NO];
            _statusLabel.text = kMatchingSuccessText;
            self.matchingState = FLPhotoMatchingStateSuccess;
            
            [ProgressHUD showSuccess:kMatchingSuccessText];
        }];

    };
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(),matchingSuccessBlock);
}
- (IBAction)comlainButtonClicked:(id)sender {
    [ProgressHUD showSuccess:kComplainSuccessText];
}
- (IBAction)likeButtonClicked:(id)sender {
    _likeButton.backgroundColor = [UIColor redColor];
}

- (void)p_hideViews:(BOOL)hide
{
    _userInfoContainerView.hidden = hide;
    _likeButton.hidden = hide;
    _complainButton.hidden = hide;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
