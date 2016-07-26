//
//  CPHelper.m
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

#import "CPHelper.h"
#import "CanapeConstants.h"


@implementation CPHelper



+(void) popupView:(UIView *)view withType:(PopupType)type {
    [self hideKeyboard];
    
    [view setBackgroundColor:RGBA(0, 0, 0, 0.3)];
    
    CGRect rect;
    for (UIView *subView in view.subviews) {
        
        
        rect = subView.frame;
        
        switch (type) {
            case POPUP_TYPE_CENTER:
                // 스케일과 알파 값을 변경
                subView.transform =  CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                [subView setAlpha:0];
                break;
                
            default:
                // subView 들을 원래 위치에서 view 크기 만큼 밑으로 내린다.
                rect.origin.y += view.frame.size.height;
                [subView setFrame:rect];
                break;
        }
        
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:view];
    
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:0.85f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGRect rect;
                         for (UIView *subView in view.subviews) {
                             
                             rect = subView.frame;
                             
                             // subView 들을 원위치
                             switch (type) {
                                 case POPUP_TYPE_CENTER:
                                     subView.transform =  CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                     [subView setAlpha:1];
                                     break;
                                     
                                 default:
                                     rect.origin.y -= view.frame.size.height;
                                     [subView setFrame:rect];
                                     
                                     break;
                             }
                             
                         }
                     }completion:nil];
    
}

+(void) closePopupView:(UIView *)view withType:(PopupType)type {
    [view setBackgroundColor:[UIColor clearColor]];
    
    switch (type) {
        case POPUP_TYPE_CENTER:
            [view removeFromSuperview];
            break;
            
        default:
            [UIView animateWithDuration:0.3f
                                  delay:0
                 usingSpringWithDamping:0.85f
                  initialSpringVelocity:1.0f
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 CGRect rect = view.frame;
                                 
                                 for (UIView *subView in view.subviews) {
                                     rect = subView.frame;
                                     rect.origin.y += view.superview.frame.size.height;
                                     [subView setFrame:rect];
                                 }
                                 
                             }completion:^(BOOL isComplete){
                                 CGRect rect = view.frame;
                                 
                                 for (UIView *subView in view.subviews) {
                                     // subView들이 현재 view 의 아래 쪽에 위치하고 있기 때문에 다시 원위치 시켜야 함.
                                     rect = subView.frame;
                                     rect.origin.y -= view.superview.frame.size.height;
                                     [subView setFrame:rect];
                                 }
                                 
                                 [view removeFromSuperview];
                             }];
            break;
    }
    
}

+(void) popupDropDownView:(UIView *)view parentView:(UIView *)parentView baseView:(UIView *)baseView {
    [self hideKeyboard];
    
    CGPoint point = [baseView.superview convertPoint:CGPointMake(baseView.frame.origin.x, baseView.frame.origin.y + baseView.frame.size.height) toView:parentView];
    CGRect startRect = CGRectMake(point.x, point.y, parentView.frame.size.width, 0);
    
    
    [view setFrame:startRect];
    [parentView addSubview:view];
    
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:0.85f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGRect endRect = CGRectMake(point.x, point.y, parentView.frame.size.width, parentView.frame.size.height - point.y);
                         [view setFrame:endRect];
                     }completion:nil];
}

+(void) closePopupDropDownView:(UIView *)view {
    [view setBackgroundColor:[UIColor clearColor]];
    
    [UIView animateWithDuration:0.3f
                          delay:0
         usingSpringWithDamping:0.85f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGPoint point = CGPointMake(view.frame.origin.x, view.frame.origin.y);
                         CGRect rect = CGRectMake(point.x, point.y, view.frame.size.width, 0);
                         
                         [view setFrame:rect];
                     }completion:^(BOOL isComplete){
                         [view removeFromSuperview];
                     }];
}

//키보드 감추기
+ (void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
