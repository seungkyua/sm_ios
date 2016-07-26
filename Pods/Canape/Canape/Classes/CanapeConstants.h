//
//  CanapeConstants.h
//  CanapeProject
//
//  Canape Software License
//  Copyright (c) 2016 BliexSoft, Inc.
//
//  Permission to use, copy, modify, and distribute this software
//  and its documentation for any purpose, without fee, and without
//  a written agreement is hereby granted, provided that the above
//  copyright notice and this and the following paragraphs appear
//  in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#ifndef CanapeConstants_h
#define CanapeConstants_h
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

#endif /* CanapeConstants_h */