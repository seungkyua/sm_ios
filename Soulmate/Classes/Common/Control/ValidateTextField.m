//
//  ValidateTextField.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 25..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ValidateTextField.h"

@interface ValidateTextField()

@property (nonatomic, strong) NSMutableParagraphStyle *style;

@end

@implementation ValidateTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self != nil) {
        [self initialize];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self initialize];
    }
    
    return self;
}

- (void) initialize {
    _style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    _style.alignment = NSTextAlignmentJustified;
    _style.firstLineHeadIndent = 10.0f;
    _style.headIndent = 10.0f;
    _style.tailIndent = -10.0f;
    
    _errorLabel = [[UILabel alloc]init];
    [_errorLabel setHidden:YES];
    
    [_errorLabel setTextColor:[UIColor redColor]];
    [_errorLabel setFont:self.font];
    [_errorLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:NULL];
    [_errorLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(errorLabelTap)];
    [tapGesture setNumberOfTapsRequired:1];
    [_errorLabel addGestureRecognizer:tapGesture];
    [self addSubview:_errorLabel];
    
    CGRect rect = self.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    [_errorLabel setFrame:rect];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    NSString *text = [change objectForKey:@"new"];
    if ([text isEqualToString:@""]) {
        [_errorLabel setHidden:YES];
    } else {
        [_errorLabel setHidden:NO];
        [self setText:@" "];
        [self resignFirstResponder];
    }
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{ NSParagraphStyleAttributeName : _style}];
    [_errorLabel setAttributedText:attrText];
}

- (void) errorLabelTap {
    [_errorLabel setHidden:YES];
    [self setText:@""];
    [self becomeFirstResponder];
}

@end
