//
//  ProfileViewController.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "BaseMainViewController.h"
#import "Combo.h"
#import "AutoResizeTextView.h"

@interface ProfileViewController : BaseMainViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgFace;
@property (strong, nonatomic) AutoResizeTextView *textDescription;
@property (weak, nonatomic) IBOutlet UITextField *textNick;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet Combo *comboSex;
@property (weak, nonatomic) IBOutlet Combo *comboBirth;
@property (weak, nonatomic) IBOutlet Combo *comboAddr1;
@property (weak, nonatomic) IBOutlet Combo *comboAddr2;

@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet Combo *comboLastSchool;
@property (weak, nonatomic) IBOutlet UITextField *textUniversity;
@property (weak, nonatomic) IBOutlet UITextField *textGraduateSchool;
@property (weak, nonatomic) IBOutlet UITextField *textCompanyName;
@property (weak, nonatomic) IBOutlet Combo *comboJob;
@property (weak, nonatomic) IBOutlet Combo *comboSalary;

@property (weak, nonatomic) IBOutlet Combo *comboBloodType;
@property (weak, nonatomic) IBOutlet Combo *comboSmoke;
@property (weak, nonatomic) IBOutlet Combo *comboDrink;
@property (weak, nonatomic) IBOutlet Combo *comboReligion;
@property (weak, nonatomic) IBOutlet Combo *comboMarriage;
@property (weak, nonatomic) IBOutlet Combo *comboMyStyle;
@property (weak, nonatomic) IBOutlet Combo *comboIdealType;

@end
