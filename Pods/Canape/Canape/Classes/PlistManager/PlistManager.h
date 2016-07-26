//
//  PlistManager.h
//  CanapeProject
//
//  Canape Software License
//  Copyright (c) 2016 BliexSoft, Inc.
//
//  Permission to use, copy, modify, and distribute this software
//  and its documentation for any purpose, without fee, and without
//  a written agreement is hereby granted, provided that the above
//  copyright notice and this and the following paragraphs appear
//  in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
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




@interface PlistManager : NSObject
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

