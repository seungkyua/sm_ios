//
//  ValidationViewController.h
//  CanapeTest
//
//  Created by bliex on 2016. 3. 10..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Canape/Canape.h>
#import "ComboSample.h"
#import "BaseMainViewController.h"

@interface ValidationViewController : BaseMainViewController

@property (weak, nonatomic) IBOutlet UITextField *targetControl1;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel1;
@property (weak, nonatomic) IBOutlet UITextField *targetControl2;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel2;
@property (weak, nonatomic) IBOutlet UITextField *targetControl3;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel3;
@property (weak, nonatomic) IBOutlet UITextField *targetControl4;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel4;
@property (weak, nonatomic) IBOutlet UITextView *targetControl5;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel5;
@property (weak, nonatomic) IBOutlet UITextField *targetControl6;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel6;
@property (weak, nonatomic) IBOutlet ComboSample *targetControl7;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel7;

- (IBAction)submit:(id)sender;
@end
