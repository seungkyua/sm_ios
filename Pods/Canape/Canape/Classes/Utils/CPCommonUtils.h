//
//  CPCommonUtils.h
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
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>
#import <netinet/in.h>
#import <sys/sysctl.h>
@interface CPCommonUtils : NSObject

//네트워크 연결상태
+ (BOOL)isNetworkConnection;
//디바이스명
+ (NSString*)deviceProductName;
//OS버전
+ (NSString*)deviceOSVersion;
//escapeXml
+ (NSString*)escapeXml:(NSString *)origin;
//unescapeXml
+ (NSString*)unescapeXml:(NSString *)origin;
//escapeHtml
+ (NSString*)escapeHtml:(NSString *)origin;
//unescapeHtml
+ (NSString*)unescapeHtml:(NSString *)origin;
//문자열 empty체크 empty면 "-"리턴
+ (NSString*) stringIsEmpty:(NSString *) aString;


@end

