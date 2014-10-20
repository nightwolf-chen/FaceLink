//
//  FLPhotoMatchingController.m
//  FaceLink
//
//  Created by nirvawolf on 19/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLPhotoMatchingController.h"

@interface FLPhotoMatchingController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
//    _userImageView.bounds = CGRectMake(0, 0,320,320);
    _userImageView.contentMode = UIViewContentModeScaleAspectFit;
    _userImageView.image = _useImage;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
