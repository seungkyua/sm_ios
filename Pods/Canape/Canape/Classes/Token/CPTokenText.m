//
//  CPTokenText.m
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

#import "CPTokenText.h"

#define TEXT_COLOR [UIColor blackColor]
#define PLACEHOLDER_COLOR [UIColor lightGrayColor]
#define TEXT_SIZE 20.0f
#define MIN_WIDTH 30.0f
#define PADDING 0.0f
#define GAP 5.0f

@interface CPTokenText ()

@property (nonatomic) CGFloat selfHeight;

@end

@implementation CPTokenText

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setLayout];
}

// 초기화
- (void) initialize {
    _padding = UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING);
    _gap = GAP;
    _textSize = TEXT_SIZE;
    
    self.tokenList = [NSMutableArray array];
    
    CPToken *tempToken = [self createTokenWithTitle:@"temp" atIndex:-1];
    CGFloat tokenHeight = tempToken.frame.size.height;
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(self.padding.left, self.padding.top, self.frame.size.width, tokenHeight)];
    [self.textView setFont:[UIFont systemFontOfSize:self.textSize]];
    [self.textView setTextColor:TEXT_COLOR];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setScrollEnabled:NO];
    [self.textView setDelegate:self];
    //self.textView.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 0);
    
    [self autoResizeTextView:self.textView];
    
    [self addSubview:self.textView];
    
}

- (void) setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;

    [self showPlaceholderText];
}

- (void) showPlaceholderText {
    if (![self isStringEmpty:self.placeholder] &&
        ([self isStringEmpty:self.textView.text] || [self.textView.text isEqualToString:self.placeholder]) &&
        self.tokenList.count == 0) {
        [self.textView setText:self.placeholder];
        [self.textView setTextColor:PLACEHOLDER_COLOR];
        [self.textView resignFirstResponder];
    } else {
        [self.textView setTextColor:TEXT_COLOR];
    }
}

- (NSArray *) selectedTokenList {
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i < self.tokenList.count; i++) {
        CPToken *token = [self.tokenList objectAtIndex:i];
        if (token.selected) {
            [arr addObject:token];
        }
    }
    
    return [NSArray arrayWithObject:arr];
}

- (void) setPadding:(UIEdgeInsets)padding {
    _padding = padding;
    
    [self setLayout];
}

- (void) setGap:(CGFloat)gap {
    _gap = gap;
    
    [self setLayout];
}

- (void) setTextSize:(int)textSize {
    _textSize = textSize;
    
    [self.textView setFont:[UIFont systemFontOfSize:textSize]];
    
    for (int i = 0; i < self.tokenList.count; i++) {
        CPToken *btn = [self.tokenList objectAtIndex:i];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:textSize]];
        [btn sizeToFit];
    }
    
    [self setLayout];
}

/**
 * @brief 마지막 인덱스에 토큰 추가
 * @param token : 토큰 타이틀
 * @return nil
 */
- (void) addToken:(NSString *)token {
    [self insertToken:token atIndex:(int)self.tokenList.count];
}

/**
 * @brief 마지막 인덱스에 토큰 추가
 * @param tokens : 토큰 타이틀 목록
 * @return nil
 */
- (void) addTokens:(NSMutableArray *)tokens {
    for (int i = 0; i < tokens.count; i++) {
        [self insertToken:[tokens objectAtIndex:i] atIndex:(int)self.tokenList.count refresh:NO];
    }
    
    [self setLayout];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenTextDidChange:)]) {
        [self.delegate tokenTextDidChange:self];
    }
}

/**
 * @brief 특정 인덱스에 토큰 추가
 * @param token : 토큰 타이틀
 * @param index : 토큰 추가할 위치
 * @return nil
 */
- (void) insertToken:(NSString *)token atIndex:(int)index {
    [self insertToken:token atIndex:index refresh:YES];
}

- (void) insertToken:(NSString *)token atIndex:(int)index refresh:(BOOL)refresh {
    if ([self isStringEmpty:token]) {
        return;
    }
    
    CPToken *btnToken = [self createTokenWithTitle:token atIndex:index];
    
    // 최대 width 지정
    if (btnToken.frame.size.width + self.padding.left + self.padding.right > self.frame.size.width) {
        [btnToken setFrame:CGRectMake(self.padding.left, btnToken.frame.origin.y, self.frame.size.width - self.padding.left - self.padding.right, btnToken.frame.size.height)];
    }
    
    [btnToken addTarget:self action:@selector(touchToken:) forControlEvents:UIControlEventTouchUpInside];
    [btnToken setDelegate:self];
    
    [self addSubview:btnToken];
    
    [self.tokenList addObject:btnToken];
    _textView.text = @"";
    
    if (refresh) {
        [self setLayout];
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenTextDidChange:)]) {
            [self.delegate tokenTextDidChange:self];
        }
    }
}

- (CPToken *) createTokenWithTitle:(NSString *)title atIndex:(int)index {
    CPToken *btnToken;
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(tokenText:buttonForTokenAtIndex:)]) {
        btnToken = [self.dataSource tokenText:self buttonForTokenAtIndex:index];
        [btnToken setTitle:title forState:UIControlStateNormal];
    } else {
        btnToken = [CPToken createTokenWithTitle:title];
    }
    [btnToken.titleLabel setFont:[UIFont systemFontOfSize:self.textSize]];
    [btnToken sizeToFit];
    
    return btnToken;
}

- (void) touchToken:(UIButton *)token {
    [token setSelected:!token.selected];
}

/**
 * @brief 마지막 인덱스의 토큰 삭제
 * @return nil
 */
- (void) removeToken {
    [self deleteTokenAtIndex:(int)self.tokenList.count - 1];
}

/**
 * @brief 모든 토큰 삭제
 * @return nil
 */
- (void) removeAllTokens {
    for (int i = (int)self.tokenList.count - 1; i > -1; i--) {
        [self deleteTokenAtIndex:i refresh:NO];
    }
    
    [self setLayout];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenTextDidChange:)]) {
        [self.delegate tokenTextDidChange:self];
    }
}

/**
 * @brief 특정 인덱스의 토큰 삭제
 * @param index : 삭제할 토큰 위치
 * @return nil
 */
- (void) deleteTokenAtIndex:(int)index {
    [self deleteTokenAtIndex:index refresh:YES];
}

- (void) deleteTokenAtIndex:(int)index refresh:(BOOL)refresh {
    if (index > -1 && index < self.tokenList.count) {
        [(UIButton *)[self.tokenList objectAtIndex:index] removeFromSuperview];
        [self.tokenList removeObjectAtIndex:index];
        
        if (refresh) {
            [self setLayout];
            
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenTextDidChange:)]) {
                [self.delegate tokenTextDidChange:self];
            }
        }
    }
}

// Subviews 배치
- (void) setLayout {
    CGFloat positionX = self.padding.left;
    CGFloat positionY = self.padding.top;
    self.lineCount = 1;
    
    for (int i = 0; i < self.tokenList.count; i++) {
        UIButton *btn = [self.tokenList objectAtIndex:i];
       
        if (positionX + btn.frame.size.width > self.frame.size.width - self.padding.right) {
            positionY += btn.frame.size.height + self.gap;
            positionX = self.padding.left;
            
            self.lineCount++;
        }
        [btn setFrame:CGRectMake(positionX, positionY, btn.frame.size.width, btn.frame.size.height)];
        
        positionX += btn.frame.size.width + self.gap;
        if (positionX + MIN_WIDTH > self.frame.size.width) {
            positionY += btn.frame.size.height + self.gap;
            positionX = self.padding.left;

            self.lineCount++;
        }
    }
    
    ///////////////////////////////
    // textView 첫 줄의 들여쓰기 시작 //
    ///////////////////////////////
    if (_textView.text != nil) {
        if ([self isStringEmpty:_textView.text]) {
            _textView.text = @" ";
        }
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
        [para setFirstLineHeadIndent:positionX - self.padding.left];
        NSDictionary *dict = @{NSParagraphStyleAttributeName : para,
                               NSFontAttributeName : [UIFont systemFontOfSize:self.textSize]};
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_textView.text];
        [attributedString addAttributes:dict range:NSMakeRange(0, _textView.text.length)];
        [_textView setAttributedText:attributedString];
        
        if ([_textView.text isEqualToString:@" "]) {
            _textView.text = @"";
        }
    }
    //////////////////////////////
    // textView 첫 줄의 들여쓰기 끝 //
    //////////////////////////////
    
    // 토큰 목록의 마지막 줄로 textView 이동
    [self.textView setFrame:CGRectMake(self.padding.left, positionY, self.frame.size.width - self.padding.left - self.padding.right, self.textView.frame.size.height)];
    
    [self autoResizeHeight];
    [self showPlaceholderText];
}

// self 의 높이 재정의
- (void) autoResizeHeight {
    if (_selfHeight != self.textView.frame.size.height + self.textView.frame.origin.y + self.padding.bottom) {
        _selfHeight = self.textView.frame.size.height + self.textView.frame.origin.y + self.padding.bottom;
        
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _selfHeight)];
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenText:changeHeight:)]) {
            [self.delegate tokenText:self changeHeight:_selfHeight];
        }
    }
}

#pragma CPTokenDelegate

- (void) touchCloseWithToken:(CPToken *)token {
    for (int i = 0; i < self.tokenList.count; i++) {
        if ([token isEqual:[self.tokenList objectAtIndex:i]]) {
            [self deleteTokenAtIndex:i];
        }
    }
}

#pragma UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    BOOL returnFlag = YES;
    
    if ([text isEqualToString: @"\n"]) {
        // 리턴 입력 시 토큰 추가
        
        [self addToken:textView.text];
        
        //[textView resignFirstResponder];
        returnFlag = NO;
    } else if(textView.text.length == 0 && [text isEqualToString:@""] && self.tokenList.count) {
        // backspace 키 입력 시
        
        UIButton *lastBtn = [self.tokenList objectAtIndex:self.tokenList.count - 1];
        UIButton *btn;
        for (int i = (int)self.tokenList.count - 1; i > -1; i--) {
            btn = [self.tokenList objectAtIndex:i];
            if (btn.selected) {
                [self deleteTokenAtIndex:i];
            } else if ([btn isEqual:lastBtn] && !btn.selected) {
                [btn setSelected:YES];
            }
        }
        
        [self showPlaceholderText];
    }
    
    [self autoResizeTextView:textView];
    [self autoResizeHeight];
    
    return returnFlag;
    
}

- (void) textViewDidChange:(UITextView *)textView {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenText:shouldChangeText:)]) {
        [self.delegate tokenText:self shouldChangeText:textView.text];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.textView.text isEqualToString:self.placeholder]) {
        [self.textView setText:@""];
        [self.textView setTextColor:TEXT_COLOR];
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenTextShouldBeginEditing:)]) {
        [self.delegate tokenTextShouldBeginEditing:self];
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self showPlaceholderText];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenTextDidEndEditing:)]) {
        [self.delegate tokenTextDidEndEditing:self];
    }
}

#pragma Utils

// textView 자동 리사이징
- (void) autoResizeTextView:(UITextView *)textView {
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
}

// String Empty 여부
- (BOOL)isStringEmpty:(NSString *)string {
    if([string length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}


@end
