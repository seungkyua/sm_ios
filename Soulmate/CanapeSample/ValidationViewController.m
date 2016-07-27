//
//  ValidationViewController.m
//  CanapeTest
//
//  Created by bliex on 2016. 3. 10..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ValidationViewController.h"

@interface ValidationViewController ()

@property (nonatomic, strong) CPValidationForm *validForm;

@end

@implementation ValidationViewController

@synthesize targetControl1;
@synthesize errorLabel1;
@synthesize targetControl2;
@synthesize errorLabel2;
@synthesize targetControl3;
@synthesize errorLabel3;
@synthesize targetControl4;
@synthesize errorLabel4;
@synthesize targetControl5;
@synthesize errorLabel5;
@synthesize targetControl6;
@synthesize errorLabel6;
@synthesize targetControl7;
@synthesize errorLabel7;

@synthesize validForm;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 초기화
    validForm = [[CPValidationForm alloc] init];
    
    // 유효성 체크할 Validater 추가
    [validForm addValidater:[[CPTextFieldValidater alloc] initWithControl:targetControl1                // 체크할 컨트롤 (TextField)
                                                               errorLabel:errorLabel1                   // 에러 표시할 Label
                                                           validationType:VALIDATION_TYPE_NOT_EMPTY     // 체크할 타입
                                                               isRealtime:TRUE]];                       // 실시간으로 체크할 것인지 여부
    
    [validForm addValidater:[[CPTextFieldValidater alloc] initWithControl:targetControl2
                                                               errorLabel:errorLabel2
                                                           validationType:VALIDATION_TYPE_NUMERIC
                                                               isRealtime:FALSE]];
    
    [validForm addValidater:[[CPTextFieldValidater alloc] initWithControl:targetControl3
                                                               errorLabel:errorLabel3
                                                           validationType:VALIDATION_TYPE_PHONE_NUMBER
                                                               isRealtime:FALSE]];
    
    [validForm addValidater:[[CPTextFieldValidater alloc] initWithControl:targetControl4
                                                               errorLabel:errorLabel4
                                                           validationType:VALIDATION_TYPE_EMAIL
                                                               isRealtime:FALSE]];
    
    [validForm addValidater:[[CPTextViewValidater alloc] initWithControl:targetControl5                 // 체크할 컨트롤 (TextView)
                                                               errorLabel:errorLabel5
                                                           validationType:VALIDATION_TYPE_ENGLISH
                                                               isRealtime:TRUE]];
    
    [validForm addValidater:[[CPTextFieldValidater alloc] initWithControl:targetControl6
                                                               errorLabel:errorLabel6
                                                           validationType:VALIDATION_TYPE_NONE
                                                               isRealtime:FALSE
                                                                minLength:4                             // 최소 글자 길이
                                                                maxLength:8]];                          // 최대 글자 길이
    
    [validForm addValidater:[[CPComboValidater alloc] initWithControl:targetControl7                    // 체크할 컨트롤 (Combo)
                                                           errorLabel:errorLabel7
                                                       validationType:VALIDATION_TYPE_NOT_EMPTY
                                                           isRealtime:FALSE
                                                            minLength:0
                                                            maxLength:3]];
    [targetControl7 setPlaceholder:@"선택하세요"];
    [targetControl7 setParent:self.view];
    [targetControl7 setPlaceholderLabelColor:[UIColor grayColor]];

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

- (IBAction)submit:(id)sender {
    // 유효성 체크
    BOOL result = [validForm validation];
    
    NSLog(@"%s", result ? "true" : "false");
}

@end
