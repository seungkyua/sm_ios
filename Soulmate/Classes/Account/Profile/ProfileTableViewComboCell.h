//
//  HomeTableViewComboCell.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 2..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Combo.h"

@interface ProfileTableViewComboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet Combo *combo;
@end
