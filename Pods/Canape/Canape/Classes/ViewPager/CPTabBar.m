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
#import "CPTabBar.h"
#import "CPViewPager.h"

@interface CPTabBar ()


@end

@implementation CPTabBar

- (instancetype)init {
    if (self == [super init]) {
        [self setup];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setup];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self setup];
        
    }
    return self;
}

- (void)setup {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.contentSize = self.bounds.size;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.tabContainerView = [[UIView alloc] initWithFrame:self.bounds];
    self.tabContainerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.scrollView addSubview:self.tabContainerView];
    
    //default color
    self.textFont = [UIFont systemFontOfSize:14];
    self.indicatorColor = [UIColor blackColor];
    self.separatorColor = self.backgroundColor;
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = [UIColor grayColor];
    self.selectedTextColor = [UIColor blackColor];
    self.tintColor = [UIColor blueColor];

    
    self.tapPerPage = 4;
    self.tabItemWidth = self.frame.size.width / self.tapPerPage;
    
}


#pragma mark - tap button create
- (void)addTabAtIndex:(NSUInteger)index {

    float tabWidth = self.tabItemWidth;
    float x = tabWidth * index;
    float height = self.frame.size.height;
    CGRect frame = CGRectMake(x, 0, tabWidth, height);
    
    //1. tabButton생성
    if ([self.delegate respondsToSelector:@selector(tabBar:tabButtonIndexPath:)]) {
        UIButton *tabButton = [self.dataSource tabBar:self tabButtonIndexPath:index];
        [tabButton setFrame:frame];
        tabButton.tag = index;
        [tabButton addTarget:self action:@selector(tabTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabContainerView addSubview:tabButton];
    }else{
        UIButton *tabButton = [[UIButton alloc] initWithFrame:frame];
        tabButton.tag = index;
        
        if ([self.titles count] > 0) {
            [tabButton setTitle:self.titles[index] forState:UIControlStateNormal];
        }else{
            UIImage *icon = self.iconImages.count >= index + 1 ? self.iconImages[index] : nil;
            if (icon) {
                NSAssert([icon isKindOfClass:[UIImage class]], @"icon image is not an UIImage object!");
                [tabButton setImage:icon forState:UIControlStateNormal];
                UIImage *selectedIcon = self.selectedIconImages.count >= index + 1 ? self.selectedIconImages[index] : nil;
                [tabButton setImage:selectedIcon forState:UIControlStateSelected];
            }
        }
        
        [tabButton setTitleColor:self.textColor forState:UIControlStateNormal];
        [tabButton setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
        tabButton.tintColor = self.tintColor;
        tabButton.titleLabel.font = self.textFont;
        [tabButton addTarget:self action:@selector(tabTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabContainerView addSubview:tabButton];
    }
    
    //2. separatorView생성
    float separatorX = x;
    float separatorY = 10;
    float separatorWidth = 1 / [UIScreen mainScreen].scale;
    float separatorHeight = height - separatorY * 2;
    CGRect separatorFrame = CGRectMake(separatorX, separatorY, separatorWidth, separatorHeight);
    UIView *separatorView = [[UIView alloc] initWithFrame:separatorFrame];
    separatorView.backgroundColor = self.separatorColor;
    separatorView.tag = -1;
    [self.tabContainerView addSubview:separatorView];
    
}

- (void)addIndicatorView {
    float height = self.indicatorViewHeight > 0 ? self.indicatorViewHeight : 2;
    float y = self.frame.size.height - height;
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.tabItemWidth, height)];
    self.indicatorView.tag = -2;
    self.indicatorView.backgroundColor = self.indicatorColor;
    [self.tabContainerView addSubview:self.indicatorView];
}


- (void)selectedTabAtIndex:(NSUInteger)idx {
    int index = (int)idx;
    int tab = ({
        int tab = 0;
        for (int i = 0; i < self.tabContainerView.subviews.count; i++) {
            UIView *subView = self.tabContainerView.subviews[i];
            if (subView.tag >= 0) {
                UIButton *tabButton = (UIButton *) subView;
                tabButton.selected = (index == tab);
                tab++;
            }
        }
        tab;
    });
    if (tab == 0) {
        return;
    }
    
    //왼쪽, 오른쪽으로 스크롤 이동이 필요환지 체크하여 스크롤 이동시켜줌.
    CGPoint scrollContentOffset = self.scrollView.contentOffset;
    
    float selectedTabX = self.tabItemWidth * index;
    if (selectedTabX - scrollContentOffset.x < 0) {
        //왼쪽으로 스크롤에서 넘어갈때.
        //NSLog(@"<<<<<<<<");
        scrollContentOffset.x -= scrollContentOffset.x - selectedTabX;
        scrollContentOffset.x  = scrollContentOffset.x < 0 ? 0 : scrollContentOffset.x;
        [self.scrollView setContentOffset:scrollContentOffset animated:YES];
    }

    float outScreenWidth = (index - (self.tapPerPage - 1)) * self.tabItemWidth;
    if (outScreenWidth - scrollContentOffset.x > 0) {
        //오른쪽 스크롤에서 넘어갈때.
        //NSLog(@">>>>>>>>");
        scrollContentOffset.x += outScreenWidth - scrollContentOffset.x;
        float maxOffsetX = self.scrollView.contentSize.width - self.frame.size.width;
        scrollContentOffset.x = scrollContentOffset.x > maxOffsetX ? maxOffsetX : scrollContentOffset.x;
        [self.scrollView setContentOffset:scrollContentOffset animated:YES];
    }

}

- (void)resetTabs {
    
    CGPoint offset = CGPointMake(0, 0);
    [self.scrollView setContentOffset:offset animated:NO];
    
    // shadow of tab bar
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
    //하위아이템 제거
    for (UIView *view in self.tabContainerView.subviews) {
        [view removeFromSuperview];
    }

    //viewPagerCount 에 따라 tabContainerView 사이즈 잡기.
    NSUInteger viewPagerCount = self.viewPager.viewControllers.count;
    self.tabItemWidth = self.frame.size.width / self.tapPerPage;
    
    if (viewPagerCount > 0 ) {
        if (viewPagerCount >= self.tapPerPage) {
            CGRect containerFrame = self.tabContainerView.frame;
            containerFrame.size.width = viewPagerCount * self.tabItemWidth;
            self.tabContainerView.frame = containerFrame;
            self.scrollView.contentSize = containerFrame.size;
        }
        //viewPager의 갯수 만큼 tab생성
        for (int i = 0; i < self.viewPager.viewControllers.count; i++) {
            [self addTabAtIndex:i];
        }
        [self addIndicatorView];
        [self selectedTabAtIndex:0];
    }
}

#pragma mark - action
- (void)tabTouch:(UIButton *)sender {
    if (self.viewPager) {
        self.selectedIndex = sender.tag;
        [self.viewPager scrollToPage:sender.tag];
    }
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectedItemAtIndex:sender.tag];
    }
}

#pragma mark - getter and setter
- (void)setViewPager:(CPViewPager *)viewPager {
    _viewPager = viewPager;
    [self resetTabs];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self selectedTabAtIndex:selectedIndex];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self resetTabs];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    [self resetTabs];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self resetTabs];
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor {
    _selectedTextColor = selectedTextColor;
    [self resetTabs];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    [self resetTabs];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    [self resetTabs];
}

- (void)setShowShadow:(BOOL)showShadow {
    _showShadow = showShadow;
    self.layer.masksToBounds = !showShadow;
}

- (void)setShadowOffest:(CGSize)shadowOffest {
    _shadowOffest = shadowOffest;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowColor = self.shadowColor ? self.shadowColor.CGColor : [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = shadowOffest;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    _shadowColor = shadowColor;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeEqualToSize(self.shadowOffest, CGSizeZero) ? CGSizeMake(0.0f, 2.0f) : self.shadowOffest;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)setTabPerPage:(NSInteger)tapPerPage {
    self.tapPerPage = tapPerPage;
    self.tabItemWidth = self.frame.size.width / self.tapPerPage;
    [self resetTabs];
}

@end
