//
//  ProfileViewController.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "BaseMainViewController.h"
#import "Combo.h"

@interface ProfileViewController : BaseMainViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgFace;
@property (weak, nonatomic) IBOutlet UITextField *textDescription;
@property (weak, nonatomic) IBOutlet UITextField *textNick;
@property (weak, nonatomic) IBOutlet Combo *comboSex;
@property (weak, nonatomic) IBOutlet Combo *comboBirth;
@property (weak, nonatomic) IBOutlet Combo *comboAddr1;
@property (weak, nonatomic) IBOutlet Combo *comboAddr2;

@end
