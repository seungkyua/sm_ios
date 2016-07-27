//
//  StackViewController.h
//  CanapeTest
//
//  Created by bliex on 2016. 3. 21..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Canape/Canape.h>
#import "BaseMainViewController.h"

@interface StackViewController : BaseMainViewController

@property (weak, nonatomic) IBOutlet CPStackView *stackView;
@property (weak, nonatomic) IBOutlet CPStackView *subStackView;
- (IBAction)touchAxisVertical:(id)sender;
- (IBAction)touchAxisHorizontal:(id)sender;
- (IBAction)touchDistributionNone:(id)sender;
- (IBAction)touchDistributionFill:(id)sender;
- (IBAction)touchDistributionEqually:(id)sender;
- (IBAction)touchAlignmentLeft:(id)sender;
- (IBAction)touchAlignmentCenter:(id)sender;
- (IBAction)touchAlignmentRight:(id)sender;
- (IBAction)touchAlignmentTop:(id)sender;
- (IBAction)touchAlignmentMiddle:(id)sender;
- (IBAction)touchAlignmentBottom:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tfPadding;
- (IBAction)touchPadding:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tfGap;
- (IBAction)touchGap:(id)sender;
- (IBAction)touchAddSubview:(id)sender;
@end
