//
//  EncryptionPlistViewController.m
//  CanapeSample
//
//  Created by bliex on 2016. 4. 11..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "EncryptionPlistViewController.h"
#import <Canape/Canape.h>
@interface EncryptionPlistViewController ()
@property (nonatomic, strong) NSMutableDictionary *settingPlist;

@end

@implementation EncryptionPlistViewController
@synthesize settingPlist;

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)initBtnTouch:(id)sender {
    [PlistManager sharedInstance];
}

- (IBAction)getBtnTouch:(id)sender {
    settingPlist = [[PlistManager sharedInstance] getPlist:PLIST_TYPE_SETTING];
}
- (IBAction)changeBtnTouch:(id)sender {
    [settingPlist setObject:@"BB" forKey:@"NEW1"];
}

- (IBAction)saveBtnTouch:(id)sender {
    [[PlistManager sharedInstance] savePlist:PLIST_TYPE_SETTING];
}
@end
