//
//  FLRecentViewController.m
//  FaceLink
//
//  Created by exitingchen on 14/10/17.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "FLRecentViewController.h"
#import "FMMacros.h"

@interface FLRecentViewController ()
@property (weak, nonatomic) IBOutlet UIView *textFieldContainer;


@end

@implementation FLRecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CGSize contentSize = SCREEN_SIZE;
    contentSize.height *= 1.2f;
    _baseScrollView.contentSize = contentSize ;
    
    // Do any additional setup after loading the view from its nib.
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


@end
