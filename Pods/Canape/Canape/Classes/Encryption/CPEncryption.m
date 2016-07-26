//
//  CPEncryption.m
//  Test
//
//  Created by bliex on 2016. 4. 4..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "CPEncryption.h"

@implementation CPEncryption


+(NSData *)AES256EncryptWithKey:(NSString *)key data:(NSMutableDictionary *) dictionary {
    NSData *data = [self dictionaryToNSData:dictionary];
    
    char keyPtr[kCCKeySizeAES256 +1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    size_t numBytesEncrypted = 0;
    void *buffer = malloc(bufferSize);
    if(!buffer) {
        return nil;
    }
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL
                                          , [data bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
    
    if(cryptStatus == kCCSuccess) {
//                NSLog(@"%@",  [self nSDataToDictionary:[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted]]);
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}


+(NSMutableDictionary *)AES256DecryptWithKey:(NSString *)key data:(NSData *)data {
    
    char keyPtr[kCCKeySizeAES256 +1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    size_t numBytesDecrypted = 0;
    void *buffer = malloc(bufferSize);
    if(!buffer) {
        return nil;
    }
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL
                                          , [data bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    
    if(cryptStatus == kCCSuccess) {
        
        return [self nSDataToDictionary:[NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted]];
    }
    
    free(buffer);
    return nil;
}

#pragma mark convert
+(NSData *) dictionaryToNSData :(NSMutableDictionary *) dictionary {
    return [NSKeyedArchiver archivedDataWithRootObject:dictionary];
}

+(NSMutableDictionary *) nSDataToDictionary :(NSData *) data {
    NSLog(@"%@", data);
    NSMutableDictionary * test =(NSMutableDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@", test);
    return test;
}
@end
