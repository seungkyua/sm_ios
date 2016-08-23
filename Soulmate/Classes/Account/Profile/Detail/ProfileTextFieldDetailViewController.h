//
//  ProfileTextViewDetailViewController.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 22..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ProfileTextDetailViewController.h"

@interface ProfileTextFieldDetailViewController : ProfileTextDetailViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnComplete;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *labelLimit;

- (IBAction)touchBtnComplete:(id)sender;
@end
