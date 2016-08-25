//
//  IntroViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "IntroViewController.h"
#import <Canape/Canape.h>

@interface IntroViewController ()

@property (nonatomic, strong) NSMutableDictionary *settingPlist;

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _settingPlist = [[PlistManager sharedInstance] getPlist:PLIST_TYPE_SETTING];
    NSString *userId = [_settingPlist objectForKey:@"USER_ID"];
    if ([userId isEqualToString:@""]) {
        [self performSelector:@selector(goGuide) withObject:nil afterDelay:1.0];
    } else {
        [self performSelector:@selector(goHome) withObject:nil afterDelay:1.0];
    }
}

- (void) goGuide {
    [self performSegueWithIdentifier:@"goGuide" sender:self];
}

- (void) goHome {
    [self performSegueWithIdentifier:@"goHome" sender:self];
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

@end
