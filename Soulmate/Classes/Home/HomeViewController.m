//
//  HomeViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goCanapeSample:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Canape" bundle:[NSBundle mainBundle]];
    UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:@"canapeNavi"];
    
    [self presentViewController:navi animated:TRUE completion:nil];
}

@end
