//
//  CPToken.m
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

#import "CPToken.h"

#define TITLE_COLOR [UIColor blackColor]
#define TITLE_COLOR_SELECTED [UIColor blackColor]
#define BG_COLOR [UIColor colorWithRed:0.859 green:0.886 blue:0.925 alpha:1.0]
#define BG_COLOR_SELECTED [UIColor colorWithRed:0.777 green:0.777 blue:0.925 alpha:1.0]
#define CORNER_RADIUS 5.0f
#define BORDER_WIDTH 1.0f
#define ICON_IMAGE @"close_icon"
#define GAP 5.0f

@implementation CPToken

+ (CPToken *) createTokenWithTitle:(NSString *)title {
    CPToken *token = [[CPToken alloc] initWithFrame:CGRectZero];
    
    token.layer.cornerRadius = CORNER_RADIUS;
    //token.layer.borderWidth = tokenBorderWidth;
    //token.layer.borderColor = tokenTintColor.CGColor;
    [token setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [token setClipsToBounds:YES];
    // 말줄임 표시
    token.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [token setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [token setTitleColor:TITLE_COLOR_SELECTED forState:UIControlStateSelected];

    [token setTitle:title forState:UIControlStateNormal];
    [token sizeToFit];
    
    [token initialize];
    
    [token setBackgroundImage:[CPToken imageFromColor:BG_COLOR rect:token.frame] forState:UIControlStateNormal];
    [token setBackgroundImage:[CPToken imageFromColor:BG_COLOR_SELECTED rect:token.frame] forState:UIControlStateSelected];
    [token setBackgroundImage:[CPToken imageFromColor:BG_COLOR_SELECTED rect:token.frame] forState:UIControlStateHighlighted];
    [token setBackgroundImage:[CPToken imageFromColor:BG_COLOR_SELECTED rect:token.frame] forState:UIControlStateHighlighted | UIControlStateSelected];
    
    return token;
}

+ (UIImage *)imageFromColor:(UIColor *)color rect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        //[self initialize];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        //[self initialize];
    }
    
    return self;
}

- (void) initialize {
    self.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    
    CGFloat spacing = GAP;
    CGFloat insetAmount = spacing / 2.0;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount + self.contentEdgeInsets.left, 0, insetAmount + self.contentEdgeInsets.right);
    
//    UIImage *img = [self resizeImage:[UIImage imageNamed:ICON_IMAGE inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:[UITraitCollection traitCollectionWithDisplayScale:[UIScreen mainScreen].scale]] resizeWidth:self.frame.size.height / 3 * 2 resizeHeight:self.frame.size.height / 3 * 2];
    
//    [self setImage:[UIImage imageNamed:ICON_IMAGE inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:[UITraitCollection traitCollectionWithDisplayScale:[UIScreen mainScreen].scale]] forState:UIControlStateNormal];

    NSString *bundlePath = [[NSBundle bundleForClass:[CPToken class]]
                            pathForResource:@"Canape" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *img = [UIImage imageNamed:ICON_IMAGE inBundle:bundle compatibleWithTraitCollection:nil];
    
    [self setImage:img forState:UIControlStateNormal];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchClose)];
    singleTap.numberOfTapsRequired = 1;
    [self.imageView setUserInteractionEnabled:YES];
    [self.imageView addGestureRecognizer:singleTap];
}

- (UIImage *)resizeImage:(UIImage *)image resizeWidth:(CGFloat)resizeWidth resizeHeight:(CGFloat)resizeHeight
{
    UIGraphicsBeginImageContext(CGSizeMake(resizeWidth, resizeHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, resizeHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, resizeWidth, resizeHeight), [image CGImage]);
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (void) touchClose {
    if (self.delegate != nil && @selector(touchCloseWithToken:)) {
        [self.delegate touchCloseWithToken:self];
    }
}

- (void)drawRect:(CGRect)rect {
    
    
  
    //self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
    //self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0, -self.titleLabel.frame.size.width);
    
}
 

@end
