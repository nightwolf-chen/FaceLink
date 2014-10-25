//
//  FLRecentViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLRecentViewController.h"
#import "FMMacros.h"
#import "Globals.h"
#import "FLFaceView.h"
#import "FLChatViewController.h"
#import "FLControllerCoordinator.h"
#include "FLMainViewController.h"
#include "TestDataCenter.h"

const double kPictureGapHorizontal = 10;
const double kPictureGapVertical = 2;

@interface FLRecentViewController ()

@property (weak, nonatomic) IBOutlet UIView *textFieldContainer;
@property (nonatomic, strong) NSArray *pictures;

@end

@implementation FLRecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CGSize contentSize = SCREEN_SIZE;
    contentSize.height *= 1.2f;
    _baseScrollView.contentSize = contentSize;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(scrollViewDidTap:)];
    [_baseScrollView addGestureRecognizer:tapGestureRecognizer];
    
    _headerView.layer.cornerRadius = kRoundedCornerRaduis;
    _headerView.layer.masksToBounds = YES;
    

    [self showPhotos];
}

- (void)showPhotos
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    NSArray *users = [TestDataCenter recentChatFriends];
    const int photoscount = 9;
    for(int i = 0 ;i < photoscount ;i++){
        FLFaceViewType type ;
        if (i == 4) {
            type = FLFaceViewTypeBig;
        }else{
            type = FLFaceViewTypeSmall;
        }
        FLUser *aUser = users[i];
        [tmpArray addObject:[FLFaceView faceViewWithType:type name:aUser.username]];
    }
    
    self.pictures = tmpArray;
    
    [self layoutPictures:tmpArray];
}

- (void)layoutPictures:(NSArray *)pictures
{
    const int startX = kPictureGapHorizontal;
    const int startY = kPictureGapVertical;
    
    int cx = startX;
    int cy = startY;
    int lx = 0;
    int ly = 0;
    
    int index = 0;
    UIButton *aView = nil;
    CGRect frame;
    for(; index < 4 ;index++){
 
        cx += lx;
        cy += ly;
        
        aView = pictures[index];
        frame = aView.frame;
        frame.origin.x = cx;
        frame.origin.y = cy;
        aView.frame = frame;
        
        lx = frame.size.width + kPictureGapHorizontal;
        [self showPicture:aView withIndex:index];
    }
    
    aView = pictures[index];
    cx = startX;
    cy = startY + frame.size.height + kPictureGapVertical;
    frame = aView.frame;
    frame.origin.x = cx;
    frame.origin.y = cy;
    aView.frame = frame;
    lx = frame.size.width + kPictureGapVertical;
    [self showPicture:aView withIndex:index];
    index++;
    
    for(; index < 7 ;index++){
        
        cx += lx;
        cy += ly;
        aView = pictures[index];
        frame = aView.frame;
        frame.origin.x = cx;
        frame.origin.y = cy;
        aView.frame = frame;
        
        lx = frame.size.width + kPictureGapHorizontal;
        [self showPicture:aView withIndex:index];
    }
    
    ly = 0;
    cy = startY + 2*(frame.size.height + kPictureGapVertical);
    
    cx = startX + 2*(frame.size.width + kPictureGapHorizontal);
    lx = frame.size.width + kPictureGapHorizontal;
    
    for(; index < 9 ;index++){
        
        aView = pictures[index];
        frame = aView.frame;
        frame.origin.x = cx;
        frame.origin.y = cy;
        aView.frame = frame;
        
        lx = frame.size.width + kPictureGapHorizontal;
        [self showPicture:aView withIndex:index];
        
        cx += lx;
        cy += ly;
    }
}

- (void)showPicture:(UIButton *)aPicture withIndex:(int)index
{
    aPicture.tag = index;
    [aPicture addTarget:self action:@selector(pictureClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_photoContainer addSubview:aPicture];
}

- (void)pictureClicked:(id)sender
{
    UIButton *theButton = sender;

    NSString *username = ((FLFaceView *)_pictures[theButton.tag]).username;
    
    if (username) {
        //Start a chatview controller.
        FLChatViewController *chatController = [[FLChatViewController alloc] initWithNibName:nil bundle:nil];
        chatController.username = username;
        [[FLControllerCoordinator sharedInstance] navigateTo:chatController];
    }
}
- (void)scrollViewDidTap:(UIGestureRecognizer *)recognizer
{
    if ([_searchTextField isFirstResponder]) {
        [_searchTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegat
- (void)textFieldDidEndEditing:(UITextField *)textField
{

}

- (IBAction)cancleSearchButtonClicked:(id)sender {
    if (_searchTextField.isFirstResponder) {
        [_searchTextField resignFirstResponder];
    }
}


- (IBAction)searchButtonClicked:(id)sender {
    [[FLControllerCoordinator sharedInstance] navigateWithinMain:FLMainViewSubControllerSearch caller:FLMainViewSubControllerRecent];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchTextField resignFirstResponder];
}

@end
