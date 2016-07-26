//
//  CPImgLoader.m
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

#import "CPImgLoader.h"

@interface CPImgLoader ()

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIImageView *imgLoading;

@end

@implementation CPImgLoader

@synthesize view;
@synthesize imgLoading;

static CPImgLoader *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (CPImgLoader *)sharedInstance {
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
        
        imgLoading = [[UIImageView alloc] init];
        imgLoading.animationImages = [NSArray arrayWithObjects:
                                      [UIImage imageNamed:@"img_loading_spinner01"],
                                      [UIImage imageNamed:@"img_loading_spinner02"],
                                      [UIImage imageNamed:@"img_loading_spinner03"],
                                      [UIImage imageNamed:@"img_loading_spinner04"],
                                      [UIImage imageNamed:@"img_loading_spinner05"],
                                      [UIImage imageNamed:@"img_loading_spinner06"],
                                      [UIImage imageNamed:@"img_loading_spinner07"],
                                      [UIImage imageNamed:@"img_loading_spinner08"],
                                      [UIImage imageNamed:@"img_loading_spinner09"],
                                      [UIImage imageNamed:@"img_loading_spinner10"],
                                      [UIImage imageNamed:@"img_loading_spinner11"],
                                      [UIImage imageNamed:@"img_loading_spinner12"], nil];
        [imgLoading sizeToFit];
        [imgLoading setAnimationRepeatCount:0];
        [view addSubview:imgLoading];
        
        rect = imgLoading.frame;
        rect.origin.x = view.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = view.frame.size.height / 2 - rect.size.height / 2;
        [imgLoading setFrame:rect];
    }
    showFlag = NO;
    showCount = 0;
    
    return self;
}

- (void) show {
    if( showFlag == NO ) {
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        [window addSubview:view];
        
        [imgLoading startAnimating];
        showFlag = YES;
    }
    showCount++;
    NSLog(@"Loader show [%d]", showCount);
}

- (void) hide {
    showCount--;
    if( showFlag == YES && showCount < 1) {
        
        [view removeFromSuperview];
        
        [imgLoading stopAnimating];
        
        showFlag = NO;
    }
    NSLog(@"Loader hide [%d]", showCount);
}

- (BOOL) isShowing {
    return showFlag;
}
@end
