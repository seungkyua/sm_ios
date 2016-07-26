//
//  CPAlert.m
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

#import "CPAlert.h"
#import "CanapeConstants.h"
#import "UIButton+BGColor.h"
#import "CPHelper.h"
#define TITLE_LABEL_FONT_SIZE 18
#define CONTENTS_LABEL_FONT_SIZE 14
#define WIDTH_DEFAULT pixelToWidth(966)
#define WIDTH_LARGE pixelToWidth(1036)
#define HEIGHT_TITLE pixelToHeight(246)
#define HEIGHT_BUTTON_AREA pixelToHeight(160)
#define HEIGHT_CONTENT_BOTTOM pixelToHeight(83)
#define HEIGHT_CONTENT_BOTTOM_NO_BUTTONS pixelToHeight(121)
#define HEIGHT_CONTENT_MIN pixelToHeight(160)
#define HEIGHT_CONTENT_MIN_NO_BUTTONS pixelToHeight(130)
#define HEIGHT_CONTENT_MAX pixelToHeight(1600)
#define PADDING_LEFT pixelToPointX(44)
#define PADDING_TOP pixelToPointY(44)

@interface CPAlert ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIControl *view;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelContentText;
@property (nonatomic, strong) UIView *buttonArea;

@end

@implementation CPAlert

@synthesize delegate;
@synthesize view;
@synthesize buttons;
@synthesize labelContentText;
@synthesize labelTitle;
@synthesize buttonArea;

- (id) initWithTitle:(NSString *)title contentText:(NSString *)contentText content:(id)content buttonTitlesArray:(NSArray *)buttonTitlesArray type:(AlertType)type {
    self = [self init];
    
    // self가 모달뷰가 됨
    [self setFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height)];
    [self addTarget:self action:@selector(onModalTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    // 컨텐츠 컨테이너 생성
    if (view == nil) {
        view = [[UIControl alloc]init];
        [view setBackgroundColor:[UIColor whiteColor]];
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        [[view layer] setBorderWidth:1.0f];
        
        [[view layer] setBorderColor:[RGB(231,231,231) CGColor]];
        [self addSubview:view];
    }
    
    CGFloat contentsHeight = 0;
    CGFloat contentWidth = 0;
    
    // type 에 따라 view의 너비가 정해짐
    if (type == ALERT_TYPE_LARGE) {
        contentWidth = WIDTH_LARGE;
    } else {
        contentWidth = WIDTH_DEFAULT;
    }
    
    CGRect rect;
    
    // 타이틀 생성
    
    if (title && ![title isEqualToString:@""]) {
        
        //텍스트 에 따라 동적 Height 구하기. 57.28
        float labelHeight = [title boundingRectWithSize:CGSizeMake(contentWidth - (PADDING_LEFT * 2), 60)
                                                options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                             attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: TITLE_LABEL_FONT_SIZE]} context:nil].size.height;
        
        
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(PADDING_LEFT, PADDING_TOP, contentWidth - (PADDING_LEFT * 2), labelHeight)];
        [labelTitle setNumberOfLines:2];
        [labelTitle setTextAlignment:NSTextAlignmentCenter];
        [labelTitle setFont:[UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE]];
        [labelTitle setTextColor:RGB(41, 52, 66)];
        [labelTitle setText:title];
        //[labelTitle sizeToFit];
        
        [view addSubview:labelTitle];
        
        contentsHeight = labelTitle.frame.origin.y + labelTitle.frame.size.height + PADDING_TOP;
    } else {
        contentsHeight += PADDING_TOP;
    }
    
    // 컨텐츠 텍스트 생성
    if (contentText && ![content isEqualToString:@""]) {
        labelContentText = [[UILabel alloc] initWithFrame:CGRectMake(PADDING_LEFT, contentsHeight, contentWidth - (PADDING_LEFT * 2), 0)];
        //[labelContentText setLineBreakMode:NSLineBreakByWordWrapping];
        [labelContentText setTextAlignment:NSTextAlignmentLeft];
        [labelContentText setNumberOfLines:0];
        [labelContentText setFont:[UIFont systemFontOfSize: CONTENTS_LABEL_FONT_SIZE]];
        [labelContentText setTextColor:RGB(41, 52, 66)];
        [view addSubview:labelContentText];

        [labelContentText setHidden:NO];
        [labelContentText setText:contentText];
        [labelContentText sizeToFit];
        
        rect =  labelContentText.frame;
        
        if (buttonTitlesArray) {
            if (labelContentText.frame.size.height < HEIGHT_CONTENT_MIN) {
                rect.size.height = HEIGHT_CONTENT_MIN;
            }
        } else {
            if (rect.size.height < HEIGHT_CONTENT_MIN_NO_BUTTONS) {
                rect.size.height = HEIGHT_CONTENT_MIN_NO_BUTTONS;
            }
        }
        
        if (rect.size.height > HEIGHT_CONTENT_MAX) {
            rect.size.height = HEIGHT_CONTENT_MAX;
        }
        [labelContentText setFrame:rect];
        
        
        contentsHeight += labelContentText.frame.size.height + (buttonTitlesArray ? HEIGHT_CONTENT_BOTTOM : HEIGHT_CONTENT_BOTTOM_NO_BUTTONS);
    }
    
    // 컨텐츠에 텍스트가 아닌 다른 뷰가 들어갈 경우 생성
    if (content) {
        if (contentText) {
            [labelContentText setHidden:YES];
        }
        
        UIView *contentView = content;
        //[contentView setBackgroundColor:[UIColor blueColor]];
        
        UIScrollView *contentScrollView = [[UIScrollView alloc] init];
        [contentScrollView setContentSize:CGSizeMake(contentView.frame.size.width, contentView.frame.size.height)];
        [contentScrollView setBounces:NO];
        //[contentScrollView setBackgroundColor:[UIColor greenColor]];
        
        
        rect = CGRectMake(0, contentsHeight, contentWidth, contentView.frame.size.height);
        if (buttonTitlesArray) {
            if (rect.size.height < HEIGHT_CONTENT_MIN) {
                rect.size.height = HEIGHT_CONTENT_MIN;
            }
        } else {
            if (rect.size.height < HEIGHT_CONTENT_MIN_NO_BUTTONS) {
                rect.size.height = HEIGHT_CONTENT_MIN_NO_BUTTONS;
            }
        }
        
        if (rect.size.height > HEIGHT_CONTENT_MAX) {
            rect.size.height = HEIGHT_CONTENT_MAX;
        }
        
        [contentScrollView setFrame:rect];
        [contentScrollView addSubview:contentView];
        [view addSubview:contentScrollView];
        
        contentsHeight += contentScrollView.frame.size.height;
    }
    
    // 버튼이 생성 되어 있으면 삭제
    if (buttons) {
        for (UIButton *button in buttons) {
            [button removeFromSuperview];
        }
        [buttons removeAllObjects];
    }
    buttons = [NSMutableArray new];
    
    // 버튼 생성
    if (buttonTitlesArray) {
        if (buttonArea == nil) {
            buttonArea = [[UIView alloc]init];
            [view addSubview:buttonArea];
        }
        
        rect = CGRectMake(0, contentsHeight, contentWidth, HEIGHT_BUTTON_AREA);
        [buttonArea setFrame:rect];
        
        CGFloat buttonWidth = (contentWidth - buttonTitlesArray.count + 1) / buttonTitlesArray.count;
        CGFloat x = 0;
        
        for (int i = 0; i < buttonTitlesArray.count; i++) {
            
            if (i > 0) {
                UIView *separator = [[UIView alloc]initWithFrame:CGRectMake(x, 0, 1, HEIGHT_BUTTON_AREA)];
                [separator setBackgroundColor:RGB(225, 227, 229)];
                [buttonArea addSubview:separator];
                
                x += 1;
            }
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, buttonWidth, HEIGHT_BUTTON_AREA)];
            [button setbackgroundColor:RGB(238, 238, 238) forState:UIControlStateNormal];
            [button setbackgroundColor:RGB(217, 217, 217) forState:UIControlStateHighlighted];
            [button setTitleColor:RGB(41, 52, 66) forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize: 50/3]];
            [button setTitle:buttonTitlesArray[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(onButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
            [[button layer] setBorderWidth:1.0f];
            [[button layer] setBorderColor:[RGB(231,231,231) CGColor]];
            [buttonArea addSubview:button];
            
            x += buttonWidth;
            
            [buttons addObject:button];
        }
        
        contentsHeight += HEIGHT_BUTTON_AREA;
    }
    
    [view setFrame:CGRectMake(DEVICE_SIZE.width / 2 - contentWidth / 2, DEVICE_SIZE.height / 2 - contentsHeight / 2, contentWidth, contentsHeight)];
    
    [view addTarget:self action:@selector(onViewTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void) show {
    [CPHelper popupView:self withType:POPUP_TYPE_CENTER];
}

- (IBAction)onViewTouch:(id)sender {
    [CPHelper hideKeyboard];
}

// 버튼 터치 이벤트 핸들러
- (IBAction)onButtonTouch:(id)sender {
    for (int i = 0; i < buttons.count; i++) {
        if (sender == buttons[i]) {
            if (delegate != nil && [delegate respondsToSelector:@selector(alert:clickedButtonAtIndex:)]) {
                [delegate alert:self clickedButtonAtIndex:i];
            }
        }
    }
    
    [CPHelper closePopupView:self withType:POPUP_TYPE_CENTER];
}

// 모달 터치 이벤트 핸들러
- (IBAction)onModalTouch:(id)sender {
    [CPHelper closePopupView:self withType:POPUP_TYPE_CENTER];
}

@end
