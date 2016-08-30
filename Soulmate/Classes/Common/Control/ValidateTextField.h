//
//  ValidateTextField.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 25..
//  Copyright © 2016년 bliex. All rights reserved.
//
//  Validation 용 TextField. errorLabel 을 포함하고 있다.
//

#import <UIKit/UIKit.h>

@interface ValidateTextField : UITextField

@property (nonatomic, strong) UILabel *errorLabel;

@end
