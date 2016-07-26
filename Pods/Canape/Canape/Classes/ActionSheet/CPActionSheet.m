//
//  CPActionSheet.m
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

#import "CPActionSheet.h"
#import "CanapeConstants.h"
#import "CPHelper.h"
#import "UIImage+CalendarCustomMethods.h"


#define HEIGHT_CONTENT_MAX pixelToHeight(1900.0f)  //actionSheet 전체 뷰 사이즈
#define BTN_WIDTH_PIXEL pixelToWidth(1070.0f) //button width
#define BTN_HEIGHT_PIXEL pixelToHeight(150.0f) //button height
#define BTN_FONT_SIZE 14
#define TITLE_FONT_SIZE 16

#define BTN_NORMAL_BACKGROUND_COLOR RGB(255, 255, 255)
#define BTN_HIGHLIGHT_BACKGROUND_COLOR RGB(245, 245, 245)
#define BACKGROUND_COLOR RGB(245, 245, 245)

#define BOTTOM_PADDING 10.0f
#define buttonHeight 55.0f
#define BTN_DEFAULT_FONT_COLOR RGB(0, 0, 0)
#define BTN_CANCEL_FONT_COLOR RGB(255, 0, 0)






@interface CPActionSheet ()
@property (nonatomic, strong) NSMutableArray *buttons;
@property (weak) id <CPActionSheetDelegate> delegate;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIScrollView *btnScrollView;
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UIView *contentsView;

@end

@implementation CPActionSheet
@synthesize delegate;
@synthesize buttons;
@synthesize cancelButton;
@synthesize btnScrollView;
@synthesize titleView;
@synthesize contentsView;

- (id) initWithTitle:(NSString *)title otherButtonTitleArray:(NSArray *)otherTitleArray cancelButtonTitle:(NSString *)cancelTitle delegate:(id)_delegate{
    
    NSMutableArray *colorArr = [NSMutableArray new];
    for (int i = 0; i < [otherTitleArray count]; i++) {
        [colorArr addObject:BTN_DEFAULT_FONT_COLOR];
    }
    return [self initWithTitle:title otherButtonTitleArray:otherTitleArray otherButtonColorArray:colorArr cancelButtonTitle:cancelTitle cancelButtonColor:BTN_CANCEL_FONT_COLOR delegate:_delegate];
}

- (id) initWithTitle:(NSString *)title otherButtonTitleArray:(NSArray *)otherTitleArray otherButtonColorArray:(NSArray *)otherColorArray cancelButtonTitle:(NSString *)cancelTitle cancelButtonColor:(UIColor *)cancelColor delegate:(id)_delegate{
    self = [self init];
    
    [self setFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height)];
    [self addTarget:self action:@selector(onModalTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self setDelegate:_delegate];
    buttons = [NSMutableArray new];
    
    CGFloat btnWidth = BTN_WIDTH_PIXEL;
    CGFloat btnHeight = BTN_HEIGHT_PIXEL;
    CGFloat x = self.frame.size.width / 2 - btnWidth / 2;
    CGFloat y = DEVICE_SIZE.height - BOTTOM_PADDING;
    
    
    // Cancel 버튼 생성
    if (cancelTitle && ![cancelTitle isEqualToString:@""]) {
        y = y - btnHeight;
        cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnWidth, btnHeight)];
        [cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:cancelColor forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[UIImage imageWithColor:BTN_NORMAL_BACKGROUND_COLOR] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[UIImage imageWithColor:BTN_HIGHLIGHT_BACKGROUND_COLOR] forState:UIControlStateHighlighted];
        [cancelButton.layer setCornerRadius:5];
        [cancelButton.layer setMasksToBounds:YES];
        
        [cancelButton addTarget:self action:@selector(onButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        [buttons addObject:cancelButton];
    }
    
    //title
    if (title && ![title isEqualToString:@""]) {
        
        //텍스트 에 따라 동적 Height 구하기. 57.28
        float labelHeight = [title boundingRectWithSize:CGSizeMake(btnWidth - 20, 60)
                                                options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                             attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: TITLE_FONT_SIZE]} context:nil].size.height;
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, btnWidth -20, labelHeight)];
        [titleLabel setNumberOfLines:2];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize: TITLE_FONT_SIZE]];
        [titleLabel setTextColor:RGB(41, 52, 66)];
        [titleLabel setText:title];
        //[titleLabel setBackgroundColor:[UIColor brownColor]];
        
        titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnWidth, titleLabel.frame.size.height + 20)];
        [titleView setBackgroundColor:BACKGROUND_COLOR];
        [titleView addSubview:titleLabel];
        
        [self addSubview:titleView];
        
    }
    
    //scrollViewHeight 사이즈 구하기
    CGFloat scrollViewHeight = 0;
    
    CGFloat scrollViewContentHeight = [otherTitleArray count] * btnHeight ; //스크롤뷰 내부 컨텐츠 사이즈
    
    CGFloat scrollViewMaxHeight = HEIGHT_CONTENT_MAX - cancelButton.frame.size.height - titleView.frame.size.height - (BOTTOM_PADDING *2); //scrollView의 MaxSize
    
    if (scrollViewContentHeight > scrollViewMaxHeight) {
        scrollViewHeight = scrollViewMaxHeight;
    }else{
        scrollViewHeight = scrollViewContentHeight;
    }
    
    btnScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height, btnWidth, scrollViewHeight)];
    
    [btnScrollView setContentSize:CGSizeMake(btnScrollView.frame.size.width, scrollViewContentHeight)];
    
    if ([otherTitleArray count] > 0) {
        for (int i = 0; i < [otherTitleArray count]; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, i * btnHeight, btnWidth, btnHeight)];
            [btn setTitle:otherTitleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:otherColorArray[i] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:BTN_NORMAL_BACKGROUND_COLOR] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:BTN_HIGHLIGHT_BACKGROUND_COLOR] forState:UIControlStateHighlighted];

            CALayer *bottomBorder = [CALayer layer];
            bottomBorder.backgroundColor = [[UIColor grayColor] CGColor];
            bottomBorder.frame = CGRectMake(0, CGRectGetHeight(btn.frame) - 0.5f, CGRectGetWidth(btn.frame), 0.5f);
            [btn.layer addSublayer:bottomBorder];
            
//            [btn.layer setMasksToBounds:YES];
//            [btn.layer setBorderWidth:0.5f];
//            [btn.layer setBorderColor:[UIColor grayColor].CGColor];
            
            [btnScrollView addSubview:btn];
            
            [btn addTarget:self action:@selector(onButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
            [buttons addObject:btn];
        }
        [btnScrollView setBackgroundColor:[UIColor whiteColor]];
    }
    
    //contentsView = titleView + btnScrollView
    contentsView = [[UIView alloc] initWithFrame:CGRectMake(x, DEVICE_SIZE.height - BOTTOM_PADDING - cancelButton.frame.size.height - BOTTOM_PADDING - btnScrollView.frame.size.height - titleView.frame.size.height, btnWidth, titleView.frame.size.height + btnScrollView.frame.size.height)];
    [contentsView.layer setCornerRadius:5];
    [contentsView.layer setMasksToBounds:YES];
    //[contentsView setBackgroundColor:[UIColor brownColor]];
    [contentsView addSubview:titleView];
    [contentsView addSubview:btnScrollView];
    [self addSubview:contentsView];
    
    
    return self;
}

- (void) show {
    [CPHelper popupView:self withType:POPUP_TYPE_DEFAULT];
}

//evnet
- (IBAction)onModalTouch:(id)sender {
    [CPHelper closePopupView:self withType:POPUP_TYPE_DEFAULT];
}

- (IBAction)onButtonTouch:(id)sender {
    for (int i = 0; i < buttons.count; i++) {
        if (sender == buttons[i]) {
            if (delegate != nil && [delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
                [delegate actionSheet:self clickedButtonAtIndex:i];
            }
        }
    }
    
    [CPHelper closePopupView:self withType:POPUP_TYPE_DEFAULT];
}
@end
