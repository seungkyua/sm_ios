//
//  CPEncryption.h
//  Test
//
//  Created by bliex on 2016. 4. 4..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#define PLIST_PASSWORD @"password"
@interface CPEncryption : NSObject

+(NSData *)AES256EncryptWithKey:(NSString *)key data:(NSMutableDictionary *) dictionary;
+(NSMutableDictionary *)AES256DecryptWithKey:(NSString *)key data:(NSData *) data;



@end
