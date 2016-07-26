//
//  CPSelectableButton.m
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

#import "CPSelectableButton.h"

#define gap 10.0f
#define iconSize 10.0f
#define iconColor [UIColor blackColor]
#define iconStrokeWidth 1.0f
#define indicatorSize iconSize / 2
#define defaultIcon @"defaultIcon"

@implementation CPSelectableButton

#pragma mark - UIView

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat marginWidth = gap;
    if (self.useIcon) {
        if (self.iconOnRight) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.frame.size.width - self.icon.size.width, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.icon.size.width, 0, marginWidth + self.icon.size.width);
            [self.titleLabel setBackgroundColor:[UIColor grayColor]];
        } else {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, marginWidth, 0, 0);
        }
    }
    
    [self setLayout];
}

#pragma CPSelectableButton

// 초기화
- (void) initialize {
    if (self.useIcon) {
        if (self.icon == nil) {
            [self setIcon:[self drawIconWithSelection:NO]];
        }
        
        if (self.selectedIcon) {
            [self setSelectedIcon:[self drawIconWithSelection:YES]];
        }
    }

    self.isSquareIcon = NO;
    self.useIcon = YES;
    self.isSelected = NO;
    
    
    [self setTintColor:iconColor];
    
    [self addTarget:self action:@selector(touchSelf) forControlEvents:UIControlEventTouchUpInside];
}

// 버튼 터치
- (void) touchSelf {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(selectableButton:withValue:)]) {
        [self.delegate selectableButton:self withValue:self.value];
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    if (self.useIcon) {
        [self setSelected:NO];
        if (isSelected) {
            [self setImage:self.selectedIcon forState:UIControlStateNormal];
        } else {
            [self setImage:self.icon forState:UIControlStateNormal];
        }
    } else {
        [self setSelected:isSelected];
    }
}

- (void) setIsSquareIcon:(BOOL)isSquareIcon {
    _isSquareIcon = isSquareIcon;
    
    if (self.icon == nil || [self.icon.accessibilityIdentifier isEqual:defaultIcon]) {
        [self setIcon:[self drawIconWithSelection:NO]];
    }
    
    if (self.selectedIcon == nil || [self.selectedIcon.accessibilityIdentifier isEqual:defaultIcon]) {
        [self setSelectedIcon:[self drawIconWithSelection:YES]];
    }
    
    [self setLayout];
}

- (void) setIcon:(UIImage *)icon {
    _icon = icon;
    
    [self setLayout];
}

- (void) setSelectedIcon:(UIImage *)selectedIcon {
    _selectedIcon = selectedIcon;
    
    [self setLayout];
}

- (void) setIconOnRight:(BOOL)iconOnRight {
    _iconOnRight = iconOnRight;
    
    [self setLayout];
}

- (id) value {
    return _value ? _value : [NSNull null];
}

// 기본 아이콘 그리기
- (UIImage *)drawIconWithSelection:(BOOL)selected {
    
    CGRect rect = CGRectMake(0, 0, iconSize, iconSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // draw icon
    UIBezierPath* iconPath;
    CGRect iconRect = CGRectMake(iconStrokeWidth / 2, iconStrokeWidth / 2, iconSize - iconStrokeWidth, iconSize - iconStrokeWidth);
    if (self.isSquareIcon) {
        iconPath = [UIBezierPath bezierPathWithRect:iconRect];
    } else {
        iconPath = [UIBezierPath bezierPathWithOvalInRect:iconRect];
    }
    iconPath.lineWidth = iconStrokeWidth;
    [iconPath stroke];
    CGContextAddPath(context, iconPath.CGPath);
    
    // draw indicator
    if (selected) {
        UIBezierPath* indicatorPath;
        CGRect indicatorRect = CGRectMake((iconSize - indicatorSize) / 2, (iconSize - indicatorSize) / 2, indicatorSize, indicatorSize);
        if (self.isSquareIcon) {
            indicatorPath = [UIBezierPath bezierPathWithRect:indicatorRect];
        } else {
            indicatorPath = [UIBezierPath bezierPathWithOvalInRect:indicatorRect];
        }
        [indicatorPath fill];
        CGContextAddPath(context, indicatorPath.CGPath);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsPopContext();
    UIGraphicsEndImageContext();
    
    image.accessibilityIdentifier = defaultIcon;
    
    
    return image;
}

- (void) setLayout {
    [self setIsSelected:_isSelected];
}

@end
