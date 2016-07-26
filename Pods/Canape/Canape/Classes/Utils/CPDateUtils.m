//
//  CPDateUtils.m
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

#import "CPDateUtils.h"

@implementation CPDateUtils

+(NSDate *)convertLocalDateToUTCDate:(NSString *)localDate dateFormat:(NSString *)localDateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:localDateFormat];
    //UTCDate NSDate형으로 변경
    NSDate * date = [formatter dateFromString:localDate];
    //UTCDate를 현지 시간으로 변경
    NSDate * utcDate = [[NSDate alloc] initWithTimeInterval: [[NSTimeZone timeZoneWithAbbreviation:@"GMT"] secondsFromGMTForDate:[NSDate date]] - [[NSTimeZone systemTimeZone] secondsFromGMTForDate:date] sinceDate:date];
    
    return utcDate;
}


+(NSDate *)convertUTCDateToLocalDate:(NSString *)utcDate dateFormat:(NSString *)utcDateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:utcDateFormat];
    
    //UTCDate NSDate형으로 변경
    NSDate * date = [formatter dateFromString:utcDate];
    
    //UTCDate를 현지 시간으로 변경
    NSDate * localDate = [[NSDate alloc] initWithTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]] - [[NSTimeZone timeZoneWithAbbreviation:@"GMT"] secondsFromGMTForDate:date] sinceDate:date];
    
    return localDate;
}

+(NSDate *)convertStringDateToNSDate:(NSString *)stringDate dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    return [formatter dateFromString:stringDate];
}

+(NSString *)convertNSDateToStringDate:(NSDate *)nsDate dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    return [formatter stringFromDate:nsDate];
}

+(NSInteger)getTimeInterval:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSTimeInterval diff = [startDate timeIntervalSinceDate:endDate];
    return diff;
}
@end
