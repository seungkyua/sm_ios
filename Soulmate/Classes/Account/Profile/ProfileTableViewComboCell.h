//
//  ProfileTableViewComboCell.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 2..
//  Copyright © 2016년 bliex. All rights reserved.
//
//  Profile Combo Cell
//

#import <UIKit/UIKit.h>
#import "Combo2.h"

@interface ProfileTableViewComboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet Combo2 *combo;
@end
