//
//  FMMacros.h
//  DoubanFM
//
//  Created by nirvawolf on 19/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#ifndef DoubanFM_FMMacros_h
#define DoubanFM_FMMacros_h

#define SAFE_DELETE(x) if(!x){ [x release]; x = nil; }; x = nil;

#define SCREEN_SIZE  [[UIScreen mainScreen] bounds].size

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

#define SCREEN_HIGHT  [[UIScreen mainScreen] bounds].size.height

#define STATUSBAR_SIZE [[UIApplication sharedApplication] statusBarFrame].size

#define STATUSBAR_HIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define STATUSBAR_WIDTH [[UIApplication sharedApplication] statusBarFrame].size.width

#define APP_DELEGATE ((FMAppDelegate *)[UIApplication sharedApplication].delegate)

#define RGB_UICOLOR(r,g,b) [UIColor colorWithRed: r/255.f green: g/255.f blue:b/255.f alpha:1]

#define RGBA_UICOLOR(r,g,b,a) [UIColor colorWithRed: r/255.f green: g/255.f blue:b/255.f alpha:a]

#define MAIN_BG_COLOR RGB_UICOLOR(112.f,196.f,241.f)

#define CONTROL_BG_COLOR RGB_UICOLOR(221.f,244.f,240.f)

#define TYPE_CHANGE(x,y) ((x)y)

#endif
