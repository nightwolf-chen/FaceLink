//
//  FLSingleOptionMenu.m
//  FaceLink
//
//  Created by nirvawolf on 19/10/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "FLSingleOptionMenu.h"
#import "FMMacros.h"
#import "FLAppSettings.h"

static const CGFloat kMenuWidth = 120;
static const CGFloat kMenuHeight = 45;
static const CGFloat kLabelWidth = 40;
static const CGFloat kLabelHeight = 20;
static const CGFloat kCheckBoxWidth = 60;
static const CGFloat kCheckBoxHeight = 30;

static const CGFloat kHorizontalMargin = 10;

@interface FLMenuOverlay : UIView
@end

@interface FLSingleOptionMenu ()
@property (nonatomic,strong) UIView *contentView;
@end

@implementation FLSingleOptionMenu

- (void)showMenuInView:(UIView *)view
              fromRect:(CGRect)rect
{
    CGFloat baseX = rect.origin.x - (kMenuWidth - rect.size.width);
    CGFloat baseY = rect.origin.y + rect.size.height*1.5;
    _contentView = [self p_contentView:rect];
    self.frame = CGRectMake(baseX, baseY, kMenuWidth, kMenuHeight);
    [self addSubview:_contentView];
    
    FLMenuOverlay *overlay = [[FLMenuOverlay alloc] initWithFrame:view.frame];
    [overlay addSubview:self];
    [view addSubview:overlay];
    
    const CGRect toFrame = self.frame;
    
    self.alpha = 0.2;
    [UIView animateWithDuration:0.2
                     animations:^(void) {
                         
                         self.alpha = 1.0f;
                         self.frame = toFrame;
                         
                     } completion:^(BOOL completed) {
                         _contentView.hidden = NO;
                     }];
    
}

- (UIView *)p_contentView:(CGRect)rect
{
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMenuWidth, kMenuHeight)];
    baseView.backgroundColor = RGBA_UICOLOR(237, 152, 169,0.6);
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(kHorizontalMargin,
                                                              (kMenuHeight-kLabelHeight)/2.0f,
                                                              kLabelWidth,
                                                              kLabelHeight)];
    text.text = @"补光";
    text.textColor = [UIColor whiteColor];
    
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kMenuWidth-kHorizontalMargin-kCheckBoxWidth,
                                                                  (kMenuHeight-kCheckBoxHeight)/2.0f,
                                                                  kMenuWidth,
                                                                  kMenuHeight)];
    aSwitch.on = [[FLAppSettings sharedSettings] ledLight];
    [aSwitch addTarget:self action:@selector(ledSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    [baseView addSubview:aSwitch];
    [baseView addSubview:text];
    
    return baseView;
}

- (void)ledSwitchChanged:(id)sender
{
    UISwitch *ledSwitch = sender;
    [[FLAppSettings sharedSettings] setLedLight:ledSwitch.on];
}

- (void)dismissMenu:(BOOL)animated
{
    if (self.superview) {
        
        if (animated) {
            
        _contentView.hidden = YES;
        [UIView animateWithDuration:0.2
        animations:^(void) {
        self.alpha = 0;
        } completion:^(BOOL finished) {
        if ([self.superview isKindOfClass:[FLMenuOverlay class]])
         [self.superview removeFromSuperview];
        [self removeFromSuperview];
        }];
            
        } else {
            
            if ([self.superview isKindOfClass:[FLMenuOverlay class]])
                [self.superview removeFromSuperview];
            [self removeFromSuperview];
        }
    }
}


@end


@implementation FLMenuOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        UITapGestureRecognizer *gestureRecognizer;
        gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(singleTap:)];
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

// thank horaceho https://github.com/horaceho
// for his solution described in https://github.com/kolyvan/kxmenu/issues/9

- (void)singleTap:(UITapGestureRecognizer *)recognizer
{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[FLSingleOptionMenu class]] && [v respondsToSelector:@selector(dismissMenu:)]) {
            
            CGRect vFrame = v.frame;
            CGPoint touchPoint = [recognizer locationInView:v.superview];
            if (!CGRectContainsPoint(vFrame, touchPoint)) {
                [v performSelector:@selector(dismissMenu:) withObject:@(YES)];
            }
        }
    }

}

@end


