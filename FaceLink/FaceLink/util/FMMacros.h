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

#endif
