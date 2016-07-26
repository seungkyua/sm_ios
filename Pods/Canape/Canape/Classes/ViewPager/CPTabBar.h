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
@class CPViewPager;
@class CPTabBar;

@protocol CPTabBarDelegate <NSObject>
/**
 * @brief 탭 버튼 선택시 호출하는 delegate
 * @param tabBar : 이벤트 발생시키는 자신을 리턴
 * @param didSelectedItemAtIndex : 선택된 아이템 index를 리턴
 * @return nil
 */
- (void)tabBar:(CPTabBar *)tabBar didSelectedItemAtIndex:(NSInteger)tabBarIndex;
@end

@protocol CPTabBarDataSource <NSObject>
@optional
/**
 * @brief 탭 버튼 을 직접넣어 줄때 사용하는 dataSource 이는 optional이다. frame은 내부에서 다시 잡는다.
 * @param tabBar : 이벤트 발생시키는 자신을 리턴
 * @param tabButtonIndexPath : button의 순서를 리턴
 * @return UIButton
 */
- (UIButton *)tabBar:(CPTabBar *)tabBar tabButtonIndexPath:(NSInteger)tabBarIndex;
@end

@interface CPTabBar : UIView

@property (weak, nonatomic) CPViewPager *viewPager;
@property (weak, nonatomic) id<CPTabBarDataSource> dataSource;
@property (weak, nonatomic) id<CPTabBarDelegate> delegate;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *tabContainerView;
@property (assign, nonatomic) CGFloat tabItemWidth;
@property (strong, nonatomic) UIView *indicatorView;

@property (assign, nonatomic) NSUInteger selectedIndex; //선택되어있는 index.
@property (assign, nonatomic) NSInteger tapPerPage; //한 화면에 보여지는 Tab의 갯수.
@property (copy, nonatomic) NSArray *titles; //tab titles
@property (copy, nonatomic) NSArray *iconImages; //tab images(nomal)
@property (copy, nonatomic) NSArray *selectedIconImages; //tab images(selected)
@property (strong, nonatomic) UIFont *textFont; //tab button text font
@property (strong, nonatomic) UIColor *textColor; //tab button text color(nomal)
@property (strong, nonatomic) UIColor *selectedTextColor; //tab button text color(selected)
@property (strong, nonatomic) UIColor *indicatorColor; //bottom line color
@property (assign, nonatomic) CGFloat indicatorViewHeight; //bottom line height
@property (strong, nonatomic) UIColor *separatorColor; //middle line color == [tab1 | tab2]
//shadow
@property (assign, nonatomic) BOOL showShadow; //bottom 그림자 여부
@property (assign, nonatomic) CGSize shadowOffest;
@property (strong, nonatomic) UIColor *shadowColor;

- (void)resetTabs;

@end
