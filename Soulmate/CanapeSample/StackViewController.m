//
//  StackViewController.m
//  CanapeTest
//
//  Created by bliex on 2016. 3. 21..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "StackViewController.h"

@interface StackViewController ()

@end

@implementation StackViewController

@synthesize stackView;
@synthesize subStackView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //stackView.distribution = CPStackViewDistributionFill;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)touchAxisVertical:(id)sender {
    stackView.axis = CPStackViewLayoutVertical;

}

- (IBAction)touchAxisHorizontal:(id)sender {
    stackView.axis = CPStackViewLayoutHorizontal;
}

- (IBAction)touchDistributionNone:(id)sender {
    stackView.distribution = CPStackViewDistributionNone;
}

- (IBAction)touchDistributionFill:(id)sender {
    stackView.distribution = CPStackViewDistributionFill;
}

- (IBAction)touchDistributionEqually:(id)sender {
    stackView.distribution = CPStackViewDistributionFillEqually;
}

- (IBAction)touchAlignmentLeft:(id)sender {
    stackView.alignment = CPStackViewAlignmentLeft;
}

- (IBAction)touchAlignmentCenter:(id)sender {
    stackView.alignment = CPStackViewAlignmentCenter;
}

- (IBAction)touchAlignmentRight:(id)sender {
    stackView.alignment = CPStackViewAlignmentRight;
}

- (IBAction)touchAlignmentTop:(id)sender {
    stackView.alignment = CPStackViewAlignmentTop;
}

- (IBAction)touchAlignmentMiddle:(id)sender {
    stackView.alignment = CPStackViewAlignmentMiddle;
}

- (IBAction)touchAlignmentBottom:(id)sender {
    stackView.alignment = CPStackViewAlignmentBottom;
}
- (IBAction)touchPadding:(id)sender {
    CGFloat padding = [_tfPadding.text floatValue];
    stackView.padding = UIEdgeInsetsMake(padding, padding, padding, padding);
}
- (IBAction)touchGap:(id)sender {
    CGFloat gap = [_tfGap.text floatValue];
    stackView.gap = gap;
}

- (IBAction)touchAddSubview:(id)sender {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [label setBackgroundColor:[UIColor brownColor]];
    [label setText:@"Label 추가"];
    [stackView addSubview:label];
}
@end
