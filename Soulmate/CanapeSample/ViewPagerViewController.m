//
//  ViewPagerViewController.m
//  CanapeSample
//
//  Created by bliex on 2016. 4. 7..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ViewPagerViewController.h"
#import <Canape/Canape.h>
#import "ViewPagerSubViewController.h"

@interface ViewPagerViewController () <CPTabBarDataSource, CPTabBarDelegate, CPViewPagerDataSource, CPViewPagerDelegate>
@property (strong, nonatomic) CPViewPager *viewPager;
@property (strong, nonatomic) CPTabBar *tabBar;
@end

@implementation ViewPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL tabisTop = YES;
    NSString *tabBarType = @"A"; //테스트를 위해 만든 타입 - A:titles, B:images, C:dataSource(tabButtonIndexPath) -- > 아래주석 해제
    self.title = @"CPViewPagerDemo";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //1.tabBar , viewPager 생성
    if (tabisTop) {
        self.tabBar = [[CPTabBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 44)];
        self.viewPager = [[CPViewPager alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.tabBar.frame),self.view.frame.size.width,
                                                                       self.view.frame.size.height - CGRectGetMaxY(self.tabBar.frame))];
        
    }else{
        self.tabBar = [[CPTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
        self.viewPager = [[CPViewPager alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame),
                                                                       self.view.frame.size.width, self.view.frame.size.height- CGRectGetMaxY(self.navigationController.navigationBar.frame)- self.tabBar.frame.size.height)];
    }
    
    self.tabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.viewPager.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //2.tab button 선택 text & image
    if ([tabBarType isEqualToString:@"A"]) {
        self.tabBar.titles = @[@"Tab0", @"Tab1", @"Tab2", @"Tab3", @"Tab4", @"Tab5", @"Tab6", @"Tab7", @"Tab8"];
    }else if([tabBarType isEqualToString:@"B"]){
        self.tabBar.iconImages = @[[UIImage imageNamed:@"tab1_icon_nor"],
                                   [UIImage imageNamed:@"tab2_icon_nor"],
                                   [UIImage imageNamed:@"tab3_icon_nor"],
                                   [UIImage imageNamed:@"tab4_icon_nor"],
                                   [UIImage imageNamed:@"tab5_icon_nor"],
                                   [UIImage imageNamed:@"tab1_icon_nor"],
                                   [UIImage imageNamed:@"tab2_icon_nor"],
                                   [UIImage imageNamed:@"tab3_icon_nor"],
                                   [UIImage imageNamed:@"tab4_icon_nor"]];
        self.tabBar.selectedIconImages = @[[UIImage imageNamed:@"tab1_icon_press"],
                                           [UIImage imageNamed:@"tab2_icon_press"],
                                           [UIImage imageNamed:@"tab3_icon_press"],
                                           [UIImage imageNamed:@"tab4_icon_press"],
                                           [UIImage imageNamed:@"tab5_icon_press"],
                                           [UIImage imageNamed:@"tab1_icon_press"],
                                           [UIImage imageNamed:@"tab2_icon_press"],
                                           [UIImage imageNamed:@"tab3_icon_press"],
                                           [UIImage imageNamed:@"tab4_icon_press"]];
    }
    
    //3.tab 속성 넣기 (갯수, 컬러, 폰트 등)
    self.tabBar.tapPerPage = 5;//한화면 tab 노출 갯수
    self.tabBar.selectedTextColor = [UIColor blueColor];//text color
    self.tabBar.indicatorColor = [UIColor blueColor]; //bottom line
    self.tabBar.separatorColor = [UIColor blueColor]; //middle line
    
    //3. 초기화 (dataSource, delegate)
    self.tabBar.delegate = self;
    self.tabBar.dataSource = self;
    self.viewPager.tabBar = self.tabBar;//view pager에 tabBar연결.
    self.viewPager.viewPagerDataSource = self;
    self.viewPager.viewPagerDelegate = self;
    
    //4. view에 붙이기
    [self.view addSubview:self.viewPager];
    [self.view addSubview:self.tabBar];
}

#pragma mark - tabBar data source(@optional)
/*
- (UIButton *)tabBar:(CPTabBar *)tabBar tabButtonIndexPath:(NSInteger)tabBarIndex{
    NSString * title = [NSString stringWithFormat:@"tab%d", (int)tabBarIndex];
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}
 */


#pragma mark - pager view data source(@required)
- (NSInteger)numberOfPageView {
    //pageView의 갯수 : tabBar의 갯수와 맞춰준다.
    return 9;
}

- (UIViewController *)viewPager:(CPViewPager *)viewPager controllerAtPage:(NSInteger)page {
    return [[ViewPagerSubViewController alloc] initWithIndex:page];
}

#pragma mark - tabbar delegate
//Tab을 선택하여 index가 변하는 경우 호출
- (void)tabBar:(CPTabBar *)tabBar didSelectedItemAtIndex:(NSInteger)tabBarIndex{
    NSLog(@"tabBarIndex : %ld", (long)tabBarIndex);
}

#pragma mark - pager view delegate
//viewPager에 guesture로 page변경 시 호출
- (void)viewPager:(CPViewPager *)viewPager didScrollToPage:(NSInteger)viewPagerIndex {
    NSLog(@"viewPagerIndex : %ld", (long)viewPagerIndex);
}
//viewPager에 좌표 변경될때 호출
- (void)viewPager:(CPViewPager *)viewPager didScrollToOffset:(CGPoint)viewPagerOffset {
}


#pragma mark - pager view delegate (scrollview delegate)
//기타 scroll이벤트를 받아야 하는경우
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"scrollViewDidScroll");
}


@end
