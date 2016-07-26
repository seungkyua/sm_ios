//
//  CPTextFieldValidater.m
//  CanapeProject
//
//  Canape Software License
//  Copyright (c) 2016 BliexSoft, Inc.
//
//  Permission to use, copy, modify, and distribute this software
//  and its documentation for any purpose, without fee, and without
//  a written agreement is hereby granted, provided that the above
//  copyright notice and this and the following paragraphs appear
//  in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "CPTextFieldValidater.h"

@implementation CPTextFieldValidater

- (id) initWithControl:(UIView *)_targetControl errorLabel:(UILabel *)_errorLabel validationType:(VALIDATION_TYPE)_validationType isRealtime:(BOOL)_isRealTime{
    self  = [super initWithControl:_targetControl errorLabel:_errorLabel validationType:_validationType isRealtime:_isRealTime];
    
    if (_isRealTime) {
        // 이벤트 핸들러 등록
        [(UITextField *) _targetControl addTarget:self
                                           action:@selector(textFieldDidChange:)
                                 forControlEvents:UIControlEventEditingChanged];
    }
    
    return self;
}

/**
 * @brief targetControl의 값 가져오기
 * @return NSString
 */
- (NSString *) targetValue {
    return [(UITextField *) self.targetControl text];
}

/**
 * @brief TextField Change Event
 * @return
 */
-(void)textFieldDidChange :(UITextField *)theTextField{
    [self isValid];
}

@end
