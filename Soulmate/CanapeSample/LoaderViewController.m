//
//  LoaderViewController.m
//  CanafeTest
//
//  Created by bliex on 2016. 2. 25..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "LoaderViewController.h"
#import <Canape/Canape.h>

@interface LoaderViewController ()
@property (strong, nonatomic) CPLoader *loader;
@property (strong, nonatomic) CPImgLoader *imgLoader;
@end

@implementation LoaderViewController
@synthesize loader;
@synthesize imgLoader;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    loader = [CPLoader sharedInstance];
    imgLoader = [CPImgLoader sharedInstance];
}



- (IBAction)defaultLoaderShow:(id)sender {
    [loader show];
    [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self
                                   selector:@selector(hideLoader:)
                                   userInfo:nil
                                    repeats:NO];
}


- (void)hideLoader:(id)sender {
    [loader hide];
}


- (IBAction)imageLoaderShow:(id)sender {
    [imgLoader show];
    [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(hideImageLoader:) userInfo:nil repeats:NO];
}

- (void)hideImageLoader:(id)sender{
    [imgLoader hide];
}

@end
