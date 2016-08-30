//
//  CommonUtil.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 19..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

/**
 * @brief JSON 문자열을 Dictionary 로 변환
 * @param jsonString : JSON 문자열
 * @return NSDictionary
 */
+ (NSDictionary *) JsonStringToObject:(NSString *) jsonString;

/**
 * @brief JSON 문자열을 배열로 변환
 * @param jsonString : JSON 문자열
 * @return NSMutableArray
 */
+ (NSMutableArray *) JsonStringToArray:(NSString *) jsonString;

/**
 * @brief Dictionary 를 JSON 문자열로 변환
 * @param object : NSMutableDictionary
 * @return NSString
 */
+ (NSString *) ObjectToJsonString:(NSMutableDictionary *) object;

/**
 * @brief 배열을 JSON 문자열로 변환
 * @param object : NSMutableArray
 * @return NSString
 */
+ (NSString *) ArrayToJsonString:(NSMutableArray *) object;

/**
 * @brief 배열에서 text로 인덱스 찾기
 * @param text : 찾을 text
 * @param array : 배열
 * @return NSInteger
 */
+ (NSInteger) findIndexByText:(NSString *) text InArray:(NSMutableArray *) array;

/**
 * @brief 배열에서 text로 data 찾기
 * @param text : 찾을 text
 * @param array : 배열
 * @return id
 */
+ (id) findDataByText:(NSString *) text InArray:(NSMutableArray *) array;

/**
 * @brief 배열에서 text로 rowData 찾기
 * @param text : 찾을 text
 * @param array : 배열
 * @return id
 */
+ (id) findRowByText:(NSString *) text InArray:(NSMutableArray *) array;

/**
 * @brief 배열에서 data로 인덱스 찾기
 * @param text : 찾을 data
 * @param array : 배열
 * @return NSInteger
 */
+ (NSInteger) findIndexByData:(NSString *) data InArray:(NSMutableArray *) array;

/**
 * @brief 배열에서 data로 text 찾기
 * @param text : 찾을 data
 * @param array : 배열
 * @return id
 */
+ (id) findTextByData:(NSString *) data InArray:(NSMutableArray *) array;

/**
 * @brief 배열에서 data로 rowData 찾기
 * @param text : 찾을 data
 * @param array : 배열
 * @return id
 */
+ (id) findRowByData:(NSString *) data InArray:(NSMutableArray *) array;

/**
 * @brief 초성 검색
 * @param compareString : 비교할 문자열
 * @param searchString : 검색할 문자열
 * @return BOOL
 */
+ (BOOL)matchString:(NSString *)compareString searchString:(NSString *)searchString;

@end
