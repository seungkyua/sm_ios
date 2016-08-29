//
//  CommonUtil.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 19..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

+ (NSDictionary *) JsonStringToObject:(NSString *) jsonString;

+ (NSMutableArray *) JsonStringToArray:(NSString *) jsonString;

+ (NSString *) ObjectToJsonString:(NSMutableDictionary *) object;

+ (NSString *) ArrayToJsonString:(NSMutableArray *) object;

+ (NSInteger) findIndexByText:(NSString *) text InArray:(NSMutableArray *) array;

+ (id) findDataByText:(NSString *) text InArray:(NSMutableArray *) array;

+ (id) findRowByText:(NSString *) text InArray:(NSMutableArray *) array;

+ (NSInteger) findIndexByData:(NSString *) data InArray:(NSMutableArray *) array;

+ (id) findTextByData:(NSString *) data InArray:(NSMutableArray *) array;
    
+ (id) findRowByData:(NSString *) data InArray:(NSMutableArray *) array;

/**
 * @brief 초성 검색
 * @param combo : 이벤트 발생한 Combo 를 리턴
 * @param text : 화면에 표시되는 값
 * @param data : data
 * @return nil
 */
+ (BOOL)matchString:(NSString *)compareString searchString:(NSString *)searchString;

@end
