//
//  CPStackView.m
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

#import "CPStackView.h"

@interface CPStackView ()

@property (nonatomic) BOOL isViewLoaded;

@end

@implementation CPStackView

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    
    if (self) {
        _axis = CPStackViewLayoutVertical;
        _padding = UIEdgeInsetsZero;
        _gap = 0;
        _distribution = CPStackViewDistributionNone;
        _alignment = CPStackViewAlignmentTop;
        
        [self setLayout];
    }
    
    return self;
}

- (instancetype) init {
    self = [super init];
    if (self != nil) {
        _axis = CPStackViewLayoutVertical;
        _padding = UIEdgeInsetsZero;
        _gap = 0;
        _distribution = CPStackViewDistributionNone;
        _alignment = CPStackViewAlignmentTop;
        
        [self setLayout];
    }
    
    return self;
}

- (void) setAxis:(CPStackViewLayoutAxis)axis {
    _axis = axis;
    
    [self setLayout];
}

- (void) setPadding:(UIEdgeInsets)padding {
    _padding = padding;
    
    [self setLayout];
}

- (void) setGap:(double)gap {
    _gap = gap;
    
    [self setLayout];
}

- (void) setDistribution:(CPStackViewDistribution)distribution {
    _distribution = distribution;
    
    [self setLayout];
}

- (void) setAlignment:(CPStackViewAlignment)alignment {
    _alignment = alignment;
    
    [self setLayout];
}

- (void) addSubview:(UIView *)view {
    // UIScrollView 생성시 기본으로 생성되는 ImageView가 있어서 구분 짓기 위해 태그 생성
    if ([view class] == [UIImageView class] && self.subviews.count < 2) {
        [view setTag:-1000];
    }
    
    [super addSubview:view];
    
    [self setLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (!_isViewLoaded) {
        [self setLayout];
        _isViewLoaded = YES;
    }
}

- (void) setLayout {
    CGRect rect;
    double position = 0;
    double contentsSize = 0;
    
    switch (self.axis) {
        // Horizontal
        case CPStackViewLayoutHorizontal:
            position = self.padding.left;
            
            for (UIView *view in [self subviews]) {
                if (view.tag != -1000) {
                    rect = view.frame;
                    
                    switch (self.distribution) {
                        case CPStackViewDistributionFill:
                            rect.origin.y = self.padding.top;
                            rect.size.height = self.frame.size.height - self.padding.top - self.padding.bottom;
                            break;
                            
                        case CPStackViewDistributionFillEqually:
                            rect.origin.y = self.padding.top;
                            rect.size.width = (self.frame.size.width - self.padding.left - self.padding.right - (self.gap * (self.subviews.count - 3))) / (self.subviews.count - 2);
                            rect.size.height = self.frame.size.height - self.padding.top - self.padding.bottom;
                            break;
                            
                        default:
                            break;
                    }
                    
                    rect.origin.x = position;
                    position += rect.size.width + self.gap;
                    
                    switch (self.alignment) {
                        case CPStackViewAlignmentTop:
                            rect.origin.y = self.padding.top;
                            break;
                            
                        case CPStackViewAlignmentMiddle:
                            rect.origin.y = self.frame.size.height / 2 - rect.size.height / 2  + self.padding.top / 2 - self.padding.bottom / 2;
                            break;
                            
                        case CPStackViewAlignmentBottom:
                            rect.origin.y = self.frame.size.height - self.padding.bottom - rect.size.height;
                            break;
                            
                        default:
                            if (rect.origin.y < self.padding.top) {
                                rect.origin.y = self.padding.top;
                            }
                            break;
                    }
                    
                    contentsSize = rect.origin.x + rect.size.width;
                    
                    [view setFrame:rect];
                    
                    if ([self class] == [view class]) {
                        [(CPStackView *) view setLayout];
                    }
                }
            } // for end
            
            [self setContentSize:CGSizeMake(contentsSize, self.frame.size.height)];
            
            break;
        
        // Vertical
        default:
            position = self.padding.top;
            
            for (UIView *view in [self subviews]) {
                if (view.tag != -1000) {
                    rect = view.frame;
                    
                    switch (self.distribution) {
                        case CPStackViewDistributionFill:
                            rect.origin.x = self.padding.left;
                            rect.size.width = self.frame.size.width - self.padding.left - self.padding.right;
                            break;
                            
                        case CPStackViewDistributionFillEqually:
                            rect.origin.x = self.padding.left;
                            rect.size.width = self.frame.size.width - self.padding.left - self.padding.right;
                            rect.size.height = (self.frame.size.height - self.padding.top - self.padding.bottom - (self.gap * (self.subviews.count - 3))) / (self.subviews.count - 2);
                            break;
                            
                        default:
                            break;
                    }
                    
                    rect.origin.y = position;
                    position += rect.size.height + self.gap;
                    
                    switch (self.alignment) {
                        case CPStackViewAlignmentLeft:
                            rect.origin.x = self.padding.left;
                            break;
                            
                        case CPStackViewAlignmentCenter:
                            rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2  + self.padding.left / 2 - self.padding.right / 2;
                            break;
                            
                        case CPStackViewAlignmentRight:
                            rect.origin.x = self.frame.size.width - self.padding.right - rect.size.width;
                            break;
                            
                        default:
                            if (rect.origin.x < self.padding.right) {
                                rect.origin.x = self.padding.right;
                            }
                            break;
                    }
                    
                    contentsSize = rect.origin.y + rect.size.height;
                    
                    [view setFrame:rect];
                    
                    if ([self class] == [view class]) {
                        [(CPStackView *) view setLayout];
                    }
                }
            } // for end
                
            [self setContentSize:CGSizeMake(self.frame.size.width, contentsSize)];
            
            break;
    }
    
    
}

@end
