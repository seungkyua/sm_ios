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

+ (id) findDataByText:(NSString *) text InArray:(NSMutableArray *) array;

+ (id) findRowByText:(NSString *) text InArray:(NSMutableArray *) array;

+ (id) findTextByData:(NSString *) data InArray:(NSMutableArray *) array;
    
+ (id) findRowByData:(NSString *) data InArray:(NSMutableArray *) array;

@end
