//
//  CPCommonUtils.m
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

#import "CPCommonUtils.h"

@implementation CPCommonUtils

+ (BOOL)isNetworkConnection{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Reachability 플래그를 설정한다.
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return 0;
    }
    // 플래그를 이용하여 각각의 네트워크 커넥션의 상태를 체크한다.
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    
    return ((isReachable && !needsConnection) || nonWiFi) ? YES : NO;
}

+ (NSString*)deviceProductName{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    // default
    return @"Unknown Apple device";
}

+ (NSString*)deviceOSVersion{
    return [[NSString alloc]initWithFormat:@"%@ %@", [[UIDevice currentDevice]systemName], [[UIDevice currentDevice]systemVersion]];
}

+ (NSString*)escapeXml:(NSString *)origin{
    if(origin == nil) {
        return @"";
    }
    
    origin = [origin stringByReplacingOccurrencesOfString:@"\"" withString:@"&#34;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"\'" withString:@"&#39;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"(" withString:@"&#40;"];
    origin = [origin stringByReplacingOccurrencesOfString:@")" withString:@"&#41;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"<" withString:@"&#60;"];
    origin = [origin stringByReplacingOccurrencesOfString:@">" withString:@"&#62;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"\\" withString:@"&#92;"];
    
    NSString *result = [[NSString alloc]initWithString:origin];
    return result;
}

+ (NSString*)unescapeXml:(NSString *)origin{
    if(origin == nil) {
        return @"";
    }
    
    origin = [origin stringByReplacingOccurrencesOfString:@"&#33;" withString:@"!"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\\\""];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#35;" withString:@"#"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#36;" withString:@"$"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#37;" withString:@"%"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#39;" withString:@"\'"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#40;" withString:@"("];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#41;" withString:@")"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#42;" withString:@"*"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#43;" withString:@"+"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#44;" withString:@","];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#45;" withString:@"-"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#46;" withString:@"."];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#47;" withString:@"/"];
    
    origin = [origin stringByReplacingOccurrencesOfString:@"&#58;" withString:@":"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#59;" withString:@";"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#60;" withString:@"<"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#61;" withString:@"="];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#62;" withString:@">"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#63;" withString:@"?"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#64;" withString:@"@"];
    
    origin = [origin stringByReplacingOccurrencesOfString:@"&#91;" withString:@"["];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#92;" withString:@"\\\\"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#93;" withString:@"]"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#94;" withString:@"^"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#95;" withString:@"_"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#96;" withString:@"`"];
    
    origin = [origin stringByReplacingOccurrencesOfString:@"&#123;" withString:@"{"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#124;" withString:@"|"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#125;" withString:@"}"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#126;" withString:@"~"];
    
    NSString *result = [[NSString alloc]initWithString:origin];
    return result;
}

+ (NSString*)escapeHtml:(NSString *)origin{
    if(origin == nil) {
        return @"";
    }
    
    origin = [origin stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"\\" withString:@"&#92;"];
    origin = [origin stringByReplacingOccurrencesOfString:@" " withString:@"&nbsp;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"\'" withString:@"&#39;"];
    origin = [origin stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    origin = [origin stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"];
    
    NSString *result = [[NSString alloc]initWithString:origin];
    return result;
}

+ (NSString*)unescapeHtml:(NSString *)origin{
    if(origin == nil) {
        return @"";
    }
    
    origin = [origin stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#39;" withString:@"\'"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    origin = [origin stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    origin = [origin stringByReplacingOccurrencesOfString:@"&#92;" withString:@"\\\\"];
    origin = [origin stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    NSString *result = [[NSString alloc]initWithString:origin];
    return result;
}

+ (NSString*) stringIsEmpty:(NSString *) aString{
    if ((NSNull *) aString == [NSNull null]) {
        return @"-";
    }
    
    if (aString == nil) {
        return @"-";
    } else if ([aString length] == 0) {
        return @"-";
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return @"-";
        }
    }
    return aString;
}

@end
