//
//  CommonUtil.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 19..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "CommonUtil.h"

#define CHOSUNG_ARRAY @[@"ㄱ",@"ㄲ",@"ㄴ",@"ㄷ",@"ㄸ",@"ㄹ",@"ㅁ",@"ㅂ",@"ㅃ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅉ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ"]
#define HANGUL_BEGIN_UNICODE 44032  // 가
#define HANGUL_END_UNICODE 55203    // 힣
#define HANGUL_BASE_UNIT 588        // 각 자음 마다 가지는 글자수

@implementation CommonUtil


+ (NSDictionary *) JsonStringToObject:(NSString *) jsonString {
    NSError* error;
    NSDictionary *data = [NSJSONSerialization
                          JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                          options:kNilOptions
                          error:&error];
    // check ERROR
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
        return nil;
    }
    
    return data;
}

+ (NSMutableArray *) JsonStringToArray:(NSString *) jsonString {
    NSError* error;
    NSMutableArray *data = [NSJSONSerialization
                          JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                          options:kNilOptions
                          error:&error];
    // check ERROR
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
        return nil;
    }
    
    return data;
}


+ (NSString *) ObjectToJsonString:(NSMutableDictionary *) object {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:object
                        options:0
                        error:&error];
    
    if (! jsonData) {
        NSLog(@"error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (NSString *) ArrayToJsonString:(NSMutableArray *) object {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:object
                        options:0
                        error:&error];
    
    if (! jsonData) {
        NSLog(@"error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (NSInteger) findIndexByText:(NSString *) text InArray:(NSMutableArray *) array {
    for (NSInteger i = 0; i < array.count; i++) {
        id obj = [array objectAtIndex:i];
        if ([[obj objectForKey:@"text"] isEqual:text]) {
            return i;
        }
    }
    
    return -1;
}

+ (id) findDataByText:(NSString *) text InArray:(NSMutableArray *) array {
    id obj = [self findRowByData:text InArray:array];
    if ([obj isKindOfClass:[NSMutableDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]]) {
        return [[self findRowByText:text InArray:array] objectForKey:@"data"];
    } else {
        return obj;
    }
}

+ (id) findRowByText:(NSString *) text InArray:(NSMutableArray *) array {
    for (id obj in array) {
        if ([obj isKindOfClass:[NSMutableDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]]) {
            if ([[obj objectForKey:@"text"] isEqual:text]) {
                return obj;
            }
        } else {
            if ([obj isEqual:text]) {
                return obj;
            }
        }
    }
    
    return nil;
}

+ (NSInteger) findIndexByData:(NSString *) data InArray:(NSMutableArray *) array {
    for (NSInteger i = 0; i < array.count; i++) {
        id obj = [array objectAtIndex:i];
        if ([obj isKindOfClass:[NSMutableDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]]) {
            if ([[obj objectForKey:@"data"] isEqual:data]) {
                return i;
            }
        } else {
            if ([obj isEqual:data]) {
                return i;
            }
        }
        
    }
    
    return -1;
}

+ (id) findTextByData:(NSString *) data InArray:(NSMutableArray *) array {
    id obj = [self findRowByData:data InArray:array];
    if ([obj isKindOfClass:[NSMutableDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]]) {
        return [[self findRowByData:data InArray:array] objectForKey:@"text"];
    } else {
        return obj;
    }
}

+ (id) findRowByData:(NSString *) data InArray:(NSMutableArray *) array {
    for (id obj in array) {
        if ([obj isKindOfClass:[NSMutableDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]]) {
            if ([[obj objectForKey:@"data"] isEqual:data]) {
                return obj;
            }
        } else {
            if ([obj isEqual:data]) {
                return obj;
            }
        }
        
    }
    
    return nil;
}

+ (BOOL)matchString:(NSString *)compareString searchString:(NSString *)searchString {
    compareString = [compareString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    searchString = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int t = 0;
    NSInteger seof = compareString.length - searchString.length;
    NSInteger slen = searchString.length;
    
    if (seof < 0 || slen == 0) {
        // 검색어가 더 길거나 검색어가 없으면 리턴
        return NO;
    }
    
    for (int i = 0; i <= seof; i++) {
        t = 0;
        while (t < slen) {
            NSInteger code = [searchString characterAtIndex:t];
            // 현재 char이 초성이고 compareString이 한글이면
            if ([self isChosung:code] && [self isHangul:[compareString characterAtIndex:i + t]]) {
                // 각각의 초성끼리 같은지 비교한다.
                if ([self getChosung:[compareString characterAtIndex:i + t]] == [searchString characterAtIndex:t]) {
                    t++;
                } else {
                    break;
                }
            } else {
                // 초성이 아닐 때는 그냥 같은지 비교
                if ([compareString characterAtIndex:i + t] == [searchString characterAtIndex:t]) {
                    t++;
                } else {
                    break;
                }
            }
        }
        
        if (t == slen) {
            return YES;
        }
    }
    
    return NO;
}

// 해당 문자가 초성인지 체크
+ (BOOL) isChosung:(NSInteger)code {
    for (NSString *chosung in CHOSUNG_ARRAY) {
        if (code == [chosung characterAtIndex:0]) {
            return YES;
        }
    }
    
    return NO;
}

// 해당 문자의 초성을 리턴
+ (NSInteger) getChosung:(NSInteger)code {
    NSInteger hanBegin = (code - HANGUL_BEGIN_UNICODE);
    NSInteger index = hanBegin / HANGUL_BASE_UNIT;
    return [[CHOSUNG_ARRAY objectAtIndex:index] characterAtIndex:0];
}

// 해당 문자가 한글인지 체크
+ (BOOL) isHangul:(NSInteger)code {
    return HANGUL_BEGIN_UNICODE <= code && code <= HANGUL_END_UNICODE;
}

@end
