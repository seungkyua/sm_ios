//
//  AutoResizeTextView.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 29..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "AutoResizeTextView.h"

@implementation AutoResizeTextView 

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
        //[self initialize];
        self.delegate = self;
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        //[self initialize];
        self.delegate = self;
    }
    
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    BOOL returnFlag = YES;
    
    double height1 = self.frame.size.height;
    
    [self autoResizeTextView:textView];
    
    double height2 = self.frame.size.height;
    
    if (self.textViewDelegate != nil && [self.textViewDelegate respondsToSelector:@selector(changeHeightWithTextView:height:)] && height1 != height2) {
        [self.textViewDelegate changeHeightWithTextView:self height:height2];
    }
    
    return returnFlag;
    
}

- (void) autoResizeTextView:(UITextView *)textView {
    CGFloat fixedWidth = self.frame.size.width;
    CGSize newSize = [self sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.frame = newFrame;
}

@end
