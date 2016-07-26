//
//  CPTokenView.m
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

#import "CPTokenView.h"

#define MAX_TOKEN_HEIGHT 200.0f
#define MIN_HEIGHT 40.0f
#define TEXT_SIZE 20
#define LABEL_TOP 7.0f
#define SUMMARY_TEXT @"%d Items.."

@interface CPTokenView ()

@property (nonatomic) CGFloat keyboardHeight;

@end

@implementation CPTokenView

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

- (void) initialize {
    _maxTokenHeight = MAX_TOKEN_HEIGHT;
    _minHeight = MIN_HEIGHT;
    _summaryText = SUMMARY_TEXT;
    _textSize = TEXT_SIZE;
    _labelTop = LABEL_TOP;
    
    self.tokenTextContainer = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.tokenTextContainer];
    
    self.tokenText = [[CPTokenText alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.tokenText setDataSource:self];
    [self.tokenText setDelegate:self];
    [self.tokenTextContainer addSubview:self.tokenText];
    
    [self setLayout];
}

- (void) registEvent {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showKeyboard:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void) removeEvent {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showKeyboard:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    _keyboardHeight = keyboardFrameBeginRect.size.height;
    
    [self removeEvent];
    
    //[self setLayout];
}

- (void) setTextSize:(int)textSize {
    _textSize = textSize;
    
    [self.tokenText setTextSize:textSize];
    
    if (self.headerLabel != nil) {
        [self.headerLabel setFont:[UIFont systemFontOfSize:textSize]];
        [self.headerLabel sizeToFit];
    }
    
    if (self.summaryLabel != nil) {
        [self.summaryLabel setFont:[UIFont systemFontOfSize:textSize]];
        [self.summaryLabel sizeToFit];
    }
    
    [self setLayout];
}

- (void) setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.tokenText.placeholder = placeholder;
}

- (void) setTokenGap:(CGFloat)tokenGap {
    _tokenGap = tokenGap;
    
    self.tokenText.gap = tokenGap;
}

- (void) touchSummaryLabel {
    [self.summaryLabel setHidden:YES];
    [self.tokenTextContainer setHidden:NO];
    [self.tokenText.textView becomeFirstResponder];
    
    [self setLayout];
}

- (void) setUseSummary:(BOOL)useSummary {
    _useSummary = useSummary;
    
    if (self.summaryLabel == nil) {
        self.summaryLabel = [[UILabel alloc]init];
        [self.summaryLabel setUserInteractionEnabled:YES];
        [self.summaryLabel setHidden:YES];
        [self.summaryLabel setFont:[UIFont systemFontOfSize:self.textSize]];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSummaryLabel)];
        [self.summaryLabel addGestureRecognizer:tapGesture];
        [self addSubview:self.summaryLabel];
    }
}

- (void) setHeaderText:(NSString *)headerText {
    _headerText = headerText;
    
    if (self.headerLabel == nil) {
        self.headerLabel = [[UILabel alloc]init];
        [self.headerLabel setFont:[UIFont systemFontOfSize:self.textSize]];
        [self addSubview:self.headerLabel];
    }
    
    [self.headerLabel setText:headerText];
    [self.headerLabel sizeToFit];
    
    [self setLayout];
}

- (void) setAutoCompleteData:(NSMutableArray *)autoCompleteData {
    _autoCompleteData = autoCompleteData;
    _autoCompleteFilterData = [NSMutableArray array];
    
    if (self.autoCompleteTableView == nil) {
        self.autoCompleteTableView = [[UITableView alloc]init];
        [self.autoCompleteTableView setDelegate:self];
        [self.autoCompleteTableView setDataSource:self];
        [self.autoCompleteTableView setHidden:YES];
        
        [self.autoCompleteTableView setBackgroundColor:[UIColor clearColor]];
        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        [self.autoCompleteTableView setTableFooterView:footerView];
        
        [self registEvent];
    }
    
    [self setLayout];
}

- (void) setLayout {
    CGFloat positionX = 0;
    CGFloat positionY = 0;
    CGRect rect;
    
    /////////////////////////////
    // headerLabel 위치 세팅 시작 //
    /////////////////////////////

    if (self.headerLabel != nil) {
        rect = self.headerLabel.frame;
        rect.origin.x = positionX;
        rect.origin.y = self.labelTop;
        [self.headerLabel setFrame:rect];
        
        positionX = rect.size.width + self.gap;
    }
    
    ///////////////////////////
    // headerLabel 위치 세팅 끝 //
    ///////////////////////////
    
    
    /////////////////////////////
    // summaryLabel 위치 세팅 시작 //
    /////////////////////////////
    
    if (self.useSummary) {
        rect = self.summaryLabel.frame;
        rect.origin.x = positionX;
        rect.origin.y = self.labelTop;
        rect.size.width = self.frame.size.width - self.gap - positionX;
        [self.summaryLabel setFrame:rect];
    }
    
    ////////////////////////////
    // summaryLabel 위치 세팅 끝 //
    ////////////////////////////
    
    
    ////////////////////////////////////
    // tokenTextContainer 위치 세팅 시작 //
    ////////////////////////////////////
    
    rect = self.tokenTextContainer.frame;
    rect.origin.x = positionX;
    rect.origin.y = positionY;
    rect.size.width = self.frame.size.width - self.gap - positionX;
    
    if (self.maxTokenHeight < self.tokenText.frame.size.height) {
        rect.size.height = self.maxTokenHeight;
    } else {
        rect.size.height = self.tokenText.frame.size.height;
    }
    
    [self.tokenTextContainer setContentSize:CGSizeMake(self.tokenText.frame.size.width, self.tokenText.frame.size.height)];
    
    CGPoint bottomOffset = CGPointMake(0, self.tokenTextContainer.contentSize.height - self.tokenTextContainer.bounds.size.height);
    [self.tokenTextContainer setContentOffset:bottomOffset animated:NO];
    
    [self.tokenTextContainer setFrame:rect];
    
    [self.tokenText setFrame:CGRectMake(0, 0, rect.size.width, self.tokenText.frame.size.height)];
    
    ////////////////////////////////////
    // tokenTextContainer 위치 세팅 끝 //
    ////////////////////////////////////
    
    
    ///////////////////////////////////////
    // autoCompleteTableView 위치 세팅 시작 //
    ///////////////////////////////////////
    
    positionY = rect.origin.y + rect.size.height;
    
    if (self.autoCompleteTableView != nil) {
        positionY += self.gap;
        
        // autoCompleteTableView의 글로벌 위치
        CGPoint point = [self convertPoint:CGPointMake(0, positionY) toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        
        rect = self.autoCompleteTableView.frame;
        rect.origin.x = point.x;
        rect.origin.y = point.y;
        rect.size.width = self.frame.size.width;
        
        rect.size.height = [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size.height - (_keyboardHeight ? _keyboardHeight + point.y : 0);
        
        [self.autoCompleteTableView setFrame:rect];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.autoCompleteTableView];
        
        positionY -= self.gap;
    }
    
    /////////////////////////////////////
    // autoCompleteTableView 위치 세팅 끝 //
    /////////////////////////////////////
    
    
    //////////////////////
    // self 크기 세팅 시작 //
    //////////////////////
    
    rect = self.frame;
    if (self.summaryLabel && !self.summaryLabel.hidden) {
        rect.size.height = self.labelTop + self.summaryLabel.frame.size.height;
    } else {
        rect.size.height = positionY;
    }
    
    if (rect.size.height < self.minHeight) {
        rect.size.height = self.minHeight;
    }
    
    if (rect.size.height != self.frame.size.height) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tokenView:changeHeight:)]) {
            [self.delegate tokenView:self changeHeight:rect.size.height];
        }
    }
    
    [self setFrame:rect];
    
    /////////////////////
    // self 크기 세팅 끝 //
    ////////////////////
}

/**
 * @brief 마지막 인덱스에 토큰 추가
 * @param token : 토큰 타이틀
 * @return nil
 */
- (void) addToken:(NSString *)token {
    [self.tokenText addToken:token];
    
    [self setSummaryLabelText];
}

/**
 * @brief 마지막 인덱스에 토큰 추가
 * @param tokens : 토큰 타이틀 목록
 * @return nil
 */
- (void) addTokens:(NSMutableArray *)tokens {
    [self.tokenText addTokens:tokens];
    
    [self setSummaryLabelText];
}

/**
 * @brief 특정 인덱스에 토큰 추가
 * @param token : 토큰 타이틀
 * @param index : 토큰 추가할 위치
 * @return nil
 */
- (void) insertToken:(NSString *)token atIndex:(int)index {
    [self.tokenText insertToken:token atIndex:index];
    
    [self setSummaryLabelText];
}

/**
 * @brief 마지막 인덱스의 토큰 삭제
 * @return nil
 */
- (void) removeToken {
    [self.tokenText removeToken];
    
    [self setSummaryLabelText];
}

/**
 * @brief 모든 토큰 삭제
 * @return nil
 */
- (void) removeAllTokens {
    [self.tokenText removeAllTokens];
    
    [self setSummaryLabelText];
}

/**
 * @brief 특정 인덱스의 토큰 삭제
 * @param index : 삭제할 토큰 위치
 * @return nil
 */
- (void) deleteTokenAtIndex:(int)index {
    [self.tokenText deleteTokenAtIndex:index];
    
    [self setSummaryLabelText];
}

- (void) setSummaryLabelText {
    if (self.useSummary) {
        if (self.tokenText.lineCount > 1 && ![self.tokenText.textView isFirstResponder]) {
            [self.tokenTextContainer setHidden:YES];
            [self.summaryLabel setText:[NSString stringWithFormat:self.summaryText, (int) self.tokenText.tokenList.count]];
            [self.summaryLabel sizeToFit];
            [self.summaryLabel setHidden:NO];
        } else {
            [self.tokenTextContainer setHidden:NO];
            [self.summaryLabel setHidden:YES];
        }
        
        [self setLayout];
    }
}

#pragma CPTokenText

- (void) tokenTextDidEndEditing:(CPTokenText *)tokenText {
    [self setSummaryLabelText];
    
    if (self.autoCompleteTableView != nil) {
        [self.autoCompleteTableView setHidden:YES];
    }
}

- (void) tokenText:(CPTokenText *)tokenText shouldChangeText:(NSString *)text {
    if (self.autoCompleteData != nil) {
        
        if (![@"" isEqualToString:text]) {
            [self.autoCompleteFilterData removeAllObjects];
            
            [self.autoCompleteFilterData removeAllObjects];
            
            for(NSString *curString in self.autoCompleteData) {
                if (([curString.lowercaseString rangeOfString: text.lowercaseString ].location != NSNotFound)) {
                    [self.autoCompleteFilterData addObject:curString];
                }
            }
            
            [self.autoCompleteTableView setHidden:NO];
            [self.autoCompleteTableView reloadData];
        } else {
            [self.autoCompleteTableView setHidden:YES];
        }
    }
}

- (void) tokenText:(CPTokenText *)tokenText changeHeight:(CGFloat)height {
    [self setLayout];
}

- (void) tokenTextDidChange:(CPTokenText *)tokenText {
    if (self.autoCompleteTableView != nil) {
        [self.autoCompleteTableView setHidden:YES];
    }
}


#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.autoCompleteFilterData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        [cell setBackgroundColor:[UIColor colorWithWhite:255 alpha:0.9f]];
    }
    
    cell.textLabel.text = [self.autoCompleteFilterData objectAtIndex:indexPath.row];
    return cell;
}


#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tokenText addToken:[self.autoCompleteFilterData objectAtIndex:indexPath.row]];
}

@end
