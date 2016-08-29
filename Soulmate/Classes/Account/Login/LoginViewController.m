//
//  LoginViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@property (nonatomic, strong) CPValidationForm *validForm;
@property (nonatomic, strong) CPSelectableButtonGroup *group;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _validForm = [[CPValidationForm alloc] init];
    
    // 유효성 체크할 Validater 추가
    [_validForm addValidater:[[CPTextFieldValidater alloc] initWithControl:_textUserId                  // 체크할 컨트롤
                                                               errorLabel:_textUserId.errorLabel        // 에러 표시할 Label
                                                           validationType:VALIDATION_TYPE_EMAIL         // 체크할 타입
                                                               isRealtime:NO]];                         // 실시간으로 체크할 것인지 여부
    
    _group = [[CPSelectableButtonGroup alloc] init];
    _group.isMultiSelectionEnable = YES;
    [_group addButton:_btnAutoLogin];
    
    [_textUserId setText:@"test@test.com"];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [_textUserId becomeFirstResponder];
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

- (IBAction)touchBtnLogin:(id)sender {
    BOOL result = [_validForm validation];
    
    NSLog(@"%s", result ? "true" : "false");
    
    if (result) {
        [self performSegueWithIdentifier:@"goHomeFromLogin" sender:self];
    }
}

- (IBAction)touchBtnFindPw:(id)sender {
}

- (IBAction)touchBtnJoin:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Join" bundle:[NSBundle mainBundle]];
    UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:@"joinNavi"];
    
    [self presentViewController:navi animated:TRUE completion:nil];
}
@end
