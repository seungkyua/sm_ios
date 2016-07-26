//
//  PlistManager.h
//  CanapeTest
//
//  Created by bliex on 2016. 3. 14..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <Foundation/Foundation.h>

//필수로 재정의 해야할것들!

#define PLIST_FILE_NAMES @[@"Setting.plist",@"SSO.plist"]
#define VERSION_KEY @"VERSION"
#define RESET_KEY @"RESET_YN"

typedef enum {
    PLIST_TYPE_SETTING,
    PLIST_TYPE_SSO
} PLIST_TYPE;




@interface EncryptionPlistManager : NSObject
@property NSMutableArray *plistTypeArr;
@property NSString *plistPath;

/**
 * @brief 초기화
 * @return PlistManager 자신
 */
+ (id)sharedInstance;

/**
 * @brief Plist 가져오기
 * @param getPlist : 가져올 PLIST_TYPE
 * @return NSMutableDictionary
 */
- (NSMutableDictionary *) getPlist:(PLIST_TYPE)_plistType;

/**
 * @brief Plist 저장
 * @param savePlist : 저장할 PLIST_TYPE
 * @return BOOL
 */
- (BOOL) savePlist:(PLIST_TYPE)_plistType;

@end

