//
//  GuideViewController.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 25..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "BaseMainViewController.h"
#import <KIImagePager/KIImagePager.h>

@interface GuideViewController : BaseMainViewController <KIImagePagerDataSource, KIImagePagerDelegate>

@property (weak, nonatomic) IBOutlet KIImagePager *imagePager;
- (IBAction)touchBtnJoin:(id)sender;
@end
