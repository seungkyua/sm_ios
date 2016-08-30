//
//  User.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 1..
//  Copyright © 2016년 bliex. All rights reserved.
//
//  Profile Model
//

#import <UIKit/UIKit.h>

@interface Profile : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) UIImage *faceImage;
@property (nonatomic, strong) NSMutableArray *faceImageList;
@property (nonatomic, strong) NSString *selfDesc;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *bodyShape;
@property (nonatomic, strong) NSString *bodyStyle;
@property (nonatomic, strong) NSString *bloodType;
@property (nonatomic, strong) NSString *lastSchool;
@property (nonatomic, strong) NSString *bodyHeight;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *smoking;
@property (nonatomic, strong) NSString *drinking;
@property (nonatomic, strong) NSString *marriage;
@property (nonatomic, strong) NSString *religion;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *universityName;
@property (nonatomic, strong) NSString *graduateSchoolName;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *income;
@property (nonatomic) BOOL instagramYn;
@property (nonatomic) BOOL facebookYn;
@property (nonatomic) BOOL telCertiYn;

@property (nonatomic, strong) NSString *matchingInterest;
@property (nonatomic, strong) NSString *matchingDate;
@property (nonatomic, strong) NSString *interestSex;
@property (nonatomic, strong) NSString *interestMarriage;
@property (nonatomic, strong) NSString *interestAgeGap;
@property (nonatomic, strong) NSString *interestArea;
@property (nonatomic, strong) NSString *interestStyle;
@property (nonatomic, strong) NSString *interestBodyHeight;
@property (nonatomic, strong) NSString *interestBodyWeight;
@property (nonatomic, strong) NSString *interestReligion;
@property (nonatomic, strong) NSString *interestDrinking;
@property (nonatomic, strong) NSString *interestSmoking;

- (void) setProfile:(NSString *) jsonString;
- (NSString *) getProfileJsonString;

@end
