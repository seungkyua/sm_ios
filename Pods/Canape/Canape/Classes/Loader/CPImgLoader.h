//
//  CPImgLoader.h
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

#import <UIKit/UIKit.h>

@interface CPImgLoader : NSObject{
    BOOL showFlag;
    int showCount;
}

/**
 * @brief Loading Spinner : 화면에서 로딩이 필요할 경우 쓰임
 * @return nil
 */
+ (id)sharedInstance;

/**
 * @brief 로딩 이미지가 보여야 할 상황에서 호출
 * @return nil
 */
- (void)show;

/**
 * @brief 로딩 이미지가 사라져야 할 상황에서 호출
 * @return nil
 */
- (void)hide;

/**
 * @brief 로딩 중인지 체크
 * @return nil
 */
- (BOOL)isShowing;

@end

