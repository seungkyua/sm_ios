//
//  CPComboBase.m
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

#import "CPComboBase.h"

@implementation CPComboBase

@synthesize delegate;

// 초기화
- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

// 초기화
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

/**
 * @brief 초기값 세팅
 * @return nil
 */
- (void) initialize {
    self.labelColor = self.textColor;
    self.placeholderLabelColor = self.textColor;
    self.userInteractionEnabled = YES;
}

/**
 * @brief Label 터치 시 선택할 목록을 화면에 표시하는 시점
 * @return nil
 */
- (void) showCombo {
    
}

/**
 * @brief 선택 목록을 화면에서 삭제하는 시점
 * @return nil
 */
- (void) hideCombo {
    
}

- (void) setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    [self setText:placeholder];
}

- (void) setPlaceholderLabelColor:(UIColor *)placeholderLabelColor {
    _placeholderLabelColor = placeholderLabelColor;
    
    [self setText:self.text];
}

- (void) setPlaceholderIndex:(NSInteger)placeholderIndex {
    _placeholderIndex = placeholderIndex;
    
    if (self.data) {
        self.placeholder = [_data objectAtIndex:placeholderIndex];
    }
}

- (void) setData:(NSMutableArray *)data {
    _data = data;
    
    if (self.placeholderIndex) {
        self.placeholder = [_data objectAtIndex:self.placeholderIndex];
    }
}

- (void) setText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        text = self.placeholder;
    }
    
    [super setText:text];
    
    if ([self.placeholder isEqualToString:text] || [text isEqualToString:@""]) {
        [self setTextColor:self.placeholderLabelColor];
    } else {
        [self setTextColor:self.labelColor];
    }
}

- (void) setValue:(NSString *)value {
    _value = value;
    
    [self setText:value];
    
    [self hideCombo];
    
    if (delegate != nil && [delegate respondsToSelector:@selector(combo:value:)]) {
        [delegate combo:self value:value];
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [self showCombo];
}


@end
