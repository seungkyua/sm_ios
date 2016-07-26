//
//  CPLoader.m
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

#import "CPLoader.h"

@interface CPLoader()

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIActivityIndicatorView *loaderView;

@end

@implementation CPLoader

@synthesize view;
@synthesize loaderView;

static CPLoader *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (CPLoader *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        view = [[UIView alloc]initWithFrame:rect];
        
        UIView *loaderGray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 54, 54)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:loaderGray.bounds cornerRadius:10.0];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = loaderGray.bounds;
        maskLayer.path = maskPath.CGPath;
        [loaderGray.layer setMask:maskLayer];
        [loaderGray setBackgroundColor:[UIColor grayColor]];
        [loaderGray setAlpha:0.6f];
        
        loaderView = [[UIActivityIndicatorView alloc] init];
        [loaderView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [loaderView sizeToFit];
        [view addSubview:loaderGray];
        [view addSubview:loaderView];
        
        rect = loaderGray.frame;
        rect.origin.x = view.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = view.frame.size.height / 2 - rect.size.height / 2;
        [loaderGray setFrame:rect];
        
        rect = loaderView.frame;
        rect.origin.x = view.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = view.frame.size.height / 2 - rect.size.height / 2;
        [loaderView setFrame:rect];
    }
    
    showFlag = NO;
    showCount = 0;
    
    return self;
}

- (void) show {

    if( showFlag == NO ) {
        
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        [window addSubview:view];
        
        [loaderView startAnimating];
        
        showFlag = YES;
    }
 
    showCount++;
    
    NSLog(@"Loader show [%d]", showCount);
}

- (void) hide {
    showCount--;
    
    if( showFlag == YES && showCount < 1) {
        
        [view removeFromSuperview];
        
        [loaderView stopAnimating];
        
        showFlag = NO;
    }
    
    NSLog(@"Loader hide [%d]", showCount);
}

- (BOOL) isShowing {
    return showFlag;
}

@end
