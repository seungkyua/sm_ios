//
//  ProfileTextViewDetailViewController.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 22..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "BaseMainViewController.h"
#import "Profile.h"

@interface ProfileTextViewDetailViewController : BaseMainViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnComplete;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *labelLimit;

@property (nonatomic, strong) Profile *profile;
@property (nonatomic, strong) NSString *type;
- (IBAction)touchBtnComplete:(id)sender;
@end
