//
//  Constants.h
//  CanapeTest
//
//  Created by bliex on 2016. 3. 3..
//  Copyright © 2016년 bliex. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
///////////////////////////////////////////////////////////////
//
//                      SIZE
//
///////////////////////////////////////////////////////////////
#define DEVICE_SIZE [[[[UIApplication sharedApplication] keyWindow] rootViewController].view convertRect:[[UIScreen mainScreen] bounds] fromView:nil].size

#define pixelToPointX(x) [UIScreen mainScreen].bounds.size.width / (1242/3) * (x/3)
#define pixelToPointY(y) [UIScreen mainScreen].bounds.size.height / (2208/3) * (y/3)

#define pixelToWidth(w) ([UIScreen mainScreen].bounds.size.width / (1242/3) * (w/3))
#define pixelToHeight(h) ([UIScreen mainScreen].bounds.size.height / (2208/3) * (h/3))


///////////////////////////////////////////////////////////////
//
//                      COLOR
//
///////////////////////////////////////////////////////////////
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HTML(rgb) RGB((double)(rgb >> 16 & 0xff), (double)(rgb >> 8 & 0xff), (double)(rgb & 0xff))

#endif /* Constants_h */

///////////////////////////////////////////////////////////////
//
//                      Menu
//
///////////////////////////////////////////////////////////////
#define kMainViewController                            (MenuViewController *)[UIApplication sharedApplication].delegate.window.rootViewController
#define kNavigationController (UINavigationController *)[(MenuViewController *)[UIApplication sharedApplication].delegate.window.rootViewController rootViewController]

#define COLOR_1 RGB(0, 87, 164) //#0057A4