//
//  SelectableButtonViewController.h
//  CanapeSample
//
//  Created by HWANGIN YONG on 2016. 3. 31..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Canape/Canape.h>
#import "BaseMainViewController.h"
@interface SelectableButtonViewController : BaseMainViewController

@property (weak, nonatomic) IBOutlet CPSelectableButton *radio1;
@property (weak, nonatomic) IBOutlet CPSelectableButton *radio2;
@property (weak, nonatomic) IBOutlet CPSelectableButton *radio3;
@property (weak, nonatomic) IBOutlet CPSelectableButton *checkbox1;
@property (weak, nonatomic) IBOutlet CPSelectableButton *checkbox2;
@property (weak, nonatomic) IBOutlet CPSelectableButton *checkbox3;
@property (weak, nonatomic) IBOutlet CPSelectableButton *custom1;
@property (weak, nonatomic) IBOutlet CPSelectableButton *custom2;
@property (weak, nonatomic) IBOutlet CPSelectableButton *custom3;
@end
