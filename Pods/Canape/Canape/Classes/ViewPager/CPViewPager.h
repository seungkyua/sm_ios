//
//  CPSelectableButton.h
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
#import "CPTabBar.h"

@class CPViewPager;

@protocol CPViewPagerDataSource <NSObject>

@required

/*
- (UIViewController *)viewPagerInViewController;
*/

/**
 * @brief viewPager(scrollView)안에 들어가는 viewControll갯수.
 * @param numberOfPageView : 선택된 아이템 index를 리턴
 * @return NSInteger
 */
- (NSInteger)numberOfPageView;

/**
 * @brief viewPager(scrollView)안에 들어가는 viewControll갯수.
 * @param numberOfPageView : 선택된 아이템 index를 리턴
 * @return NSInteger
 */
- (UIViewController *)viewPager:(CPViewPager *)viewPager
               controllerAtPage:(NSInteger)page;

@end

@protocol UIScrollViewDelegateAdapter <UIScrollViewDelegate>

@end

@protocol CPViewPagerDelegate <NSObject>
- (void)viewPager:(CPViewPager *)viewPager didScrollToPage:(NSInteger)viewPagerIndex;
- (void)viewPager:(CPViewPager *)viewPager didScrollToOffset:(CGPoint)viewPagerOffset;

@end

@interface CPViewPager : UIScrollView

@property (strong, nonatomic) CPTabBar *tabBar;
@property (nonatomic, weak) id<UIScrollViewDelegateAdapter> delegateAdapter;
@property (weak, nonatomic) id<CPViewPagerDataSource> viewPagerDataSource;
@property (weak, nonatomic) id<CPViewPagerDelegate> viewPagerDelegate;

@property (copy, nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic, readonly) NSInteger currentPage;

- (void)reloadData;
/**
 * scroll to page with animated
 */
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;

@end
