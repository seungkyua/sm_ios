//
//  ProfileViewController.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "BaseMainViewController.h"

@interface ProfileViewController : BaseMainViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgFace;
@property (weak, nonatomic) IBOutlet UITextField *textDescription;
@property (weak, nonatomic) IBOutlet UITextField *textNick;
@property (weak, nonatomic) IBOutlet UIButton *btnSex;
@property (weak, nonatomic) IBOutlet UIButton *btnBirth;
@property (weak, nonatomic) IBOutlet UIButton *btnAddr;
- (IBAction)touchSex:(id)sender;
- (IBAction)touchBirth:(id)sender;
- (IBAction)touchAddr:(id)sender;
@end
