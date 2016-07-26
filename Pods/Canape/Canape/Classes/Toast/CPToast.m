//
//  CPToast.m
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

#import "CPToast.h"

@implementation CPToast
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame text:(NSString*)text
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAlpha:0.0];
        //배경 생성
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bg.layer.cornerRadius = 20;
        bg.layer.masksToBounds = YES;
        [[bg layer] setBorderWidth:0.5f];
        [[bg layer] setBorderColor:[UIColor grayColor].CGColor];
        [bg setBackgroundColor:[UIColor blackColor]];
        [bg setAlpha:0.5];
        [self addSubview:bg];
        
        //텍스트 생성
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, frame.size.width - 10, frame.size.height)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.numberOfLines = TOAST_NUMBER_OF_NINES;
        textLabel.font = [UIFont systemFontOfSize:TOAST_FONT_SIZE];
        textLabel.textAlignment = NSTextAlignmentCenter;
        //textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        textLabel.text = text;
        [self addSubview:textLabel];
    }
    return self;
}

+ (void)showToast:(NSString *)text{
    
    [self showToast:text duaration:TOAST_DURATION delegate:nil];
    
}

+ (void)showToast:(NSString *)text delegate:(id)delegate{
    
    [self showToast:text duaration:TOAST_DURATION delegate:delegate];
    
}

+ (void)showToast:(NSString *)text duaration:(float)duration{
    [self showToast:text duaration:duration delegate:nil];
}

+ (void)showToast:(NSString *)text duaration:(float)duration delegate:(id)delegate{
    
    UIWindow *topView = [[[UIApplication sharedApplication] delegate] window];
    
    float appVersion = [[UIDevice currentDevice].systemVersion floatValue];
    
    if (appVersion >= 9.0) {
        for (UIWindow *window in [[UIApplication sharedApplication] windows])
        {
            if ([NSStringFromClass([window class]) isEqualToString:@"UIRemoteKeyboardWindow"]) {
                topView = window;
                break;
            }
            
            
        }
        
    } else {
        for (UIWindow *window in [[UIApplication sharedApplication] windows])
        {
            if (![[window class] isEqual:[UIWindow class]])
            {
                topView = window;
                break;
            }
        }
    }

    float toastWidth = pixelToWidth(WIDTH_TOAST_PIXEL);
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, toastWidth - 10, 0)];
    textLabel.numberOfLines = TOAST_NUMBER_OF_NINES;
    textLabel.font = [UIFont systemFontOfSize:TOAST_FONT_SIZE];
    textLabel.text = text;
    [textLabel sizeToFit];
    
    //텍스트 에 따라 동적 Height 구하기.
//    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TOAST_FONT_SIZE]}];
//    CGRect textRect = [attributedStr boundingRectWithSize:(CGSize){toastWidth - 10, CGFLOAT_MAX}
//                                                  options:NSStringDrawingTruncatesLastVisibleLine
//                                                  context:nil];
    
    float toastHeight = textLabel.frame.size.height + 30; //위, 아래 padding 15;
    
    if (toastHeight > topView.frame.size.height - 150) {
        toastHeight = topView.frame.size.height - 150;
    }
    
    float xOrigin = topView.frame.size.width / 2 - toastWidth / 2;
    float yOrigin = topView.frame.size.height - (pixelToHeight(BOTTOM_PADDING_PIXEL) + toastHeight);
    
    CGRect selfFrame = CGRectMake(xOrigin, yOrigin, toastWidth, toastHeight);
    
    CPToast *toast = [[CPToast alloc] initWithFrame:selfFrame text:text];
    toast.delegate = delegate;
    
    [topView addSubview:toast];

    [UIView animateWithDuration:0.4 animations:^{
        toast.alpha = 1.0f;
    }completion:^(BOOL finished) {
        if(finished){
            
        }
    }];
    

    [toast performSelector:@selector(hideSelf) withObject:nil afterDelay:duration];

}

- (void)hideSelf
{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if(finished){
            if (delegate != nil && [delegate respondsToSelector:@selector(didToastHideComplete)]) {
                // delegate 호출
                [delegate didToastHideComplete];
            }
            
            [self removeFromSuperview];
        }
    }];
}


@end
