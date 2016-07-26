//
//  CPDateUtils.h
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

@interface CPDateUtils : NSObject

//지역시간(시스템 타임존)을 UTCDate로 변경
+(NSDate *) convertLocalDateToUTCDate : (NSString *)localDate dateFormat:(NSString *)localDateFormat;

//UTC시간을 지역시간(시스템 타임존)으로 변경
+(NSDate *) convertUTCDateToLocalDate:(NSString *)utcDate dateFormat:(NSString *)utcDateFormat;

//문자열시간을 NSDate로 변경
+(NSDate *) convertStringDateToNSDate:(NSString *)stringDate dateFormat:(NSString *)dateFormat;

//NSDate를 문자열로 변경
+(NSString *) convertNSDateToStringDate:(NSDate *)nsDate dateFormat:(NSString *)dateFormat;

//시간차이
+(NSInteger) getTimeInterval:(NSDate *)startDate endDate:(NSDate *)endDate;


@end
