//
//  GuideViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 25..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imagePager.dataSource = self;
    _imagePager.delegate = self;
    
    
//    _imagePager.pageControl.center = CGPointMake(CGRectGetWidth(_imagePager.frame) / 2, CGRectGetHeight(_imagePager.frame) - 42);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _imagePager.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 이미지 세팅
- (NSArray *) arrayWithImages:(KIImagePager*)pager
{
    return @[[UIImage imageNamed:@"defaultFace"],
             @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen1.png",
             @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen2.png",
             @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen3.png"
             ];
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager*)pager
{
    return UIViewContentModeScaleAspectFill;
}

//- (NSString *) captionForImageAtIndex:(NSUInteger)index inPager:(KIImagePager*)pager
//{
//    return @[
//             @"First screenshot",
//             @"Another screenshot",
//             @"Last one! ;-)"
//             ][index];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)touchBtnJoin:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Join" bundle:[NSBundle mainBundle]];
    UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:@"joinNavi"];
    
    [self presentViewController:navi animated:TRUE completion:nil];
}
@end
