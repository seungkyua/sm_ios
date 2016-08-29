//
//  ProfileTextViewDetailViewController.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 22..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "BaseMainViewController.h"
#import "Profile.h"

@interface ProfileTextDetailViewController : BaseMainViewController

@property (nonatomic, strong) Profile *profile;
@property (nonatomic, strong) NSString *type;
@property (nonatomic) NSInteger limitBytes;
@property (nonatomic) BOOL autoCompleteEnable;

@end
