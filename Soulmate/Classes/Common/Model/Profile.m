//
//  User.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 1..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "Profile.h"
#import "CommonUtil.h"

@implementation Profile

- (id) init {
    self = [super init];
    
    _sex = @"M";
    _age = @"1980";
    _bodyShape = @"A";
    _bodyStyle = @"A";
    _bloodType = @"A";
    _lastSchool = @"A";
    _bodyHeight = @"A";
    _area = @"A";
    _smoking = @"A";
    _drinking = @"A";
    _marriage = @"A";
    _religion = @"A";
    _job = @"A";
    _income = @"A";
    
    _matchingInterest = @"A";
    _matchingDate = @"A";
    _interestSex = @"A";
    _interestArea = @"A";
    _interestStyle = @"A";
    _interestBodyHeight = @"A";
    _interestBodyWeight = @"A";
    _interestAgeGap = @"A";
    _interestSmoking = @"A";
    _interestDrinking = @"A";
    _interestMarriage = @"A";
    _interestReligion = @"A";
    
    return self;
}

- (void) setProfile:(NSString *)jsonString {
    NSDictionary *profileData = [CommonUtil JsonStringToObject:jsonString];
    
    _userId = profileData[@"id"];
    _selfDesc = profileData[@"self_desc"];
    _nickName = profileData[@"nick_name"];
    _name = profileData[@"name"];
    _sex = profileData[@"sex"];
    _age = profileData[@"age"];
    _bodyShape = profileData[@"body_shape"];
    _bodyStyle = profileData[@"body_style"];
    _bloodType = profileData[@"blood_type"];
    _lastSchool = profileData[@"last_school"];
    _bodyHeight = profileData[@"body_height"];
    _area = profileData[@"area"];
    _smoking = profileData[@"smoking_fl"];
    _drinking = profileData[@"drinking_fl"];
    _marriage = profileData[@"marriage_fl"];
    _religion = profileData[@"religion"];
    _companyName = profileData[@"company_name"];
    _universityName = profileData[@"university_name"];
    _graduateSchoolName = profileData[@"graudate_school_name"];
    _job = profileData[@"job"];
    _income = profileData[@"income"];
    _instagramYn = profileData[@"instagram_fl"];
    _facebookYn = profileData[@"facebook_fl"];
    _telCertiYn = profileData[@"tel_certi_fl"];
    
    _matchingInterest = profileData[@"matching_interest"];
    _matchingDate = profileData[@"matching_date"];
    _interestSex = profileData[@"interest_sex"];
    _interestMarriage = profileData[@"interest_marriage"];
    _interestAgeGap = profileData[@"interest_age_gap"];
    _interestArea = profileData[@"interest_area"];
    _interestStyle = profileData[@"interest_style"];
    _interestBodyHeight = profileData[@"interest_body_height"];
    _interestBodyWeight = profileData[@"interest_body_weight"];
    _interestReligion = profileData[@"interest_religion"];
    _interestDrinking = profileData[@"interest_drinking"];
    _interestSmoking = profileData[@"interest_smoking"];
}

- (NSString *) getProfileJsonString {
    NSMutableDictionary *profileData = [NSMutableDictionary dictionary];
    
    profileData[@"id"] = _userId;
    profileData[@"self_desc"] = _selfDesc;
    profileData[@"nick_name"] = _nickName;
    profileData[@"name"] = _name;
    profileData[@"sex"] = _sex;
    profileData[@"age"] = _age;
    profileData[@"body_shape"] = _bodyShape;
    profileData[@"body_style"] = _bodyStyle;
    profileData[@"blood_type"] = _bloodType;
    profileData[@"last_school"] = _lastSchool;
    profileData[@"body_height"] = _bodyHeight;
    profileData[@"area"] = _area;
    profileData[@"smoking_fl"] = _smoking;
    profileData[@"drinking_fl"] = _drinking;
    profileData[@"marriage_fl"] = _marriage;
    profileData[@"religion"] = _religion;
    profileData[@"company_name"] = _companyName;
    profileData[@"university_name"] = _universityName;
    profileData[@"graudate_school_name"] = _graduateSchoolName;
    profileData[@"job"] = _job;
    profileData[@"income"] = _income;
    profileData[@"instagram_fl"] = _instagramYn ? @"Y" : @"N";
    profileData[@"facebook_fl"] = _facebookYn ? @"Y" : @"N";
    profileData[@"tel_certi_fl"] = _telCertiYn ? @"Y" : @"N";
    
    profileData[@"matching_interest"] = _matchingInterest;
    profileData[@"matching_date"] = _matchingDate;
    profileData[@"interest_sex"] = _interestSex;
    profileData[@"interest_marriage"] = _interestMarriage;
    profileData[@"interest_age_gap"] = _interestAgeGap;
    profileData[@"interest_area"] = _interestArea;
    profileData[@"interest_style"] = _interestStyle;
    profileData[@"interest_body_height"] = _interestBodyHeight;
    profileData[@"interest_body_weight"] = _interestBodyWeight;
    profileData[@"interest_religion"] = _interestReligion;
    profileData[@"interest_drinking"] = _interestDrinking;
    profileData[@"interest_smoking"] = _interestSmoking;
    
    return [CommonUtil ObjectToJsonString:profileData];

}

@end
