//
//  CommonUtil.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 19..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "CommonUtil.h"

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

@end
