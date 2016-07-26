//
//  CPValidationForm.m
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

#import "CPValidationForm.h"

@interface CPValidationForm ()

@property (nonatomic, strong) NSMutableArray *validaterList;

@end

@implementation CPValidationForm

@synthesize validaterList;

- (id) init {
    self = [super init];
    
    // 초기화
    validaterList = [NSMutableArray array];
    
    return self;
}


/**
 * @brief 초기화
 * @param validater
 * @return void
 */
- (id) initWithValidater:(CPValidater *) validater {
    self = [self init];
    
    // validater 추가
    [self addValidater:validater];
    
    return self;
}

/**
 * @brief Validater 추가
 * @param validater
 * @return void
 */
- (void) addValidater:(CPValidater *) validater {
    [validaterList addObject:validater];
}

/**
 * @brief Validater 목록의 유효성 체크
 * @return 유효성 여부
 */
- (BOOL) validation {
    BOOL result = TRUE;
    
    for ( id obj in validaterList ) {
        if (obj != nil && ([obj respondsToSelector:@selector(isValid)])) {
            if (result) {
                result = [obj isValid];
            } else {
                [obj isValid];
            }
        }
    }
    
    return result;
}

@end
