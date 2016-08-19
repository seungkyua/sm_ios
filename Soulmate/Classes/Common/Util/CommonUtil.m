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

+ (id) findDataByText:(NSString *) text InArray:(NSMutableArray *) array {
    return [[self findRowByText:text InArray:array] objectForKey:@"data"];
}

+ (id) findRowByText:(NSString *) text InArray:(NSMutableArray *) array {
    for (id obj in array) {
        if ([[obj objectForKey:@"text"] isEqual:text]) {
            NSLog(@"text, data : %@, %@", [obj objectForKey:@"text"], [obj objectForKey:@"data"]);
            return obj;
        }
    }
    
    return nil;
}

+ (id) findTextByData:(NSString *) data InArray:(NSMutableArray *) array {
    return [[self findRowByData:data InArray:array] objectForKey:@"text"];
}

+ (id) findRowByData:(NSString *) data InArray:(NSMutableArray *) array {
    for (id obj in array) {
        if ([[obj objectForKey:@"data"] isEqual:data]) {
            NSLog(@"text, data : %@, %@", [obj objectForKey:@"text"], [obj objectForKey:@"data"]);
            return obj;
        }
    }
    
    return nil;
}

@end
