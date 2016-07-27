//
//  ViewPagerSubViewController.m
//  CanapeSample
//
//  Created by bliex on 2016. 4. 7..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ViewPagerSubViewController.h"

@interface ViewPagerSubViewController ()
@property NSInteger index;
@end

@implementation ViewPagerSubViewController

- (instancetype)initWithIndex:(NSInteger)index {
    if (self == [super init]) {
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad {
    self.title = [NSString stringWithFormat:@"VC%ld", (long)self.index];
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"ViewController%ld", (long)self.index];
    label.font = [UIFont systemFontOfSize:40];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    
}

@end
