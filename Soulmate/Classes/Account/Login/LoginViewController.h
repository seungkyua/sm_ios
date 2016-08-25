//
//  LoginViewController.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "BaseMainViewController.h"
#import "ValidateTextField.h"
#import <Canape/Canape.h>

@interface LoginViewController : BaseMainViewController

@property (weak, nonatomic) IBOutlet ValidateTextField *textUserId;
@property (weak, nonatomic) IBOutlet UITextField *textPw;
@property (weak, nonatomic) IBOutlet CPSelectableButton *btnAutoLogin;
- (IBAction)touchBtnLogin:(id)sender;
- (IBAction)touchBtnFindPw:(id)sender;
- (IBAction)touchBtnJoin:(id)sender;
@end
