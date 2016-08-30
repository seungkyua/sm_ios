//
//  ProfileTableViewTextViewCell.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 2..
//  Copyright © 2016년 bliex. All rights reserved.
//
//  Profile TextView Cell
//

#import <UIKit/UIKit.h>
#import "AutoResizeTextView.h"

@interface ProfileTableViewTextViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AutoResizeTextView *textView;
@end
