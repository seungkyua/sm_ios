//
//  TokenViewController.m
//  CanapeSample
//
//  Created by HWANGIN YONG on 2016. 4. 11..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "TokenViewController.h"
#import <Canape/Canape.h>

@interface TokenViewController () <CPTokenViewDelegate>

@property (nonatomic, strong) CPTokenView *tokenView;
@property (nonatomic, strong) CPTokenView *tokenView2;

@end

@implementation TokenViewController


@synthesize tokenView;
@synthesize tokenView2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    tokenView = [[CPTokenView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    [tokenView setHeaderText:@" 수신 : "];
    [tokenView setUseSummary:YES];
    [tokenView setPlaceholder:@"입력하세요"];
    [tokenView setDelegate:self];
    //[tokenView setTextSize:30];
    [tokenView setAutoCompleteData:[NSMutableArray arrayWithObjects:@"Gildong", @"Hong", @"Kim", @"Mugae", @"John", @"Bobby", @"홍길동", @"아무개", @"철수", @"영희", @"갑돌이", @"갑순이", @"남수", @"보라", nil]];
    [self.view addSubview:tokenView];
    
    tokenView2 = [[CPTokenView alloc]initWithFrame:CGRectMake(0, tokenView.frame.origin.y + tokenView.frame.size.height, self.view.frame.size.width, 50)];
    [tokenView2 setHeaderText:@" 참조 : "];
    //[tokenView2 setUseSummary:YES];
    [tokenView2 setPlaceholder:@"입력하세요"];
    [tokenView2 setDelegate:self];
    [self.view addSubview:tokenView2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tokenView:(CPTokenView *)_tokenView changeHeight:(CGFloat)height {
    if ([_tokenView isEqual:tokenView]) {
        [tokenView2 setFrame:CGRectMake(tokenView2.frame.origin.x, tokenView.frame.origin.y + height, tokenView2.frame.size.width, tokenView2.frame.size.height)];
    } else {
        
    }
    
}

- (IBAction)addToken:(id)sender {
    [tokenView addTokens:[NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil]];
}

- (IBAction)removeAllToken:(id)sender {
    [tokenView removeAllTokens];
}
@end
