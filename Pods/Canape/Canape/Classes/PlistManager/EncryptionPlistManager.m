//
//  PlistManager.m
//  CanapeTest
//
//  Created by bliex on 2016. 3. 14..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "EncryptionPlistManager.h"
#import "CPEncryption.h"

@implementation EncryptionPlistManager
@synthesize plistTypeArr; //documnet의 plist들을 PLIST_FILE_NAMES 순서로 가져와 저장
@synthesize plistPath;

static EncryptionPlistManager *sharedInstance = nil;



+ (EncryptionPlistManager *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super alloc] init];
    }
    
    return sharedInstance;
}

- (id)init{
    
    
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    plistTypeArr = [[NSMutableArray alloc] init];

    NSArray *fileList = PLIST_FILE_NAMES;

    for (int i = 0; i  < [fileList count]; i++) {
        
        NSString *fileName = fileList[i];
        NSArray *fileNameSplitArr = [fileName componentsSeparatedByString:@"."];
        plistPath = [documentsDirectory stringByAppendingPathComponent:fileName]; //저장위치
        NSString *bundle = [[NSBundle mainBundle] pathForResource:fileNameSplitArr[0] ofType:fileNameSplitArr[1]]; //origin plist 정보
        NSLog(@"%@", bundle);
        if (![fileManager fileExistsAtPath: plistPath]){
            //1. plist file check후 없을경우 - documents 로 copy
            NSLog(@"%@ 파일이 존재하지 않음 document로 copy", fileName);
//            [fileManager copyItemAtPath:bundle toPath: plistPath error:&error];
            
            
            NSMutableDictionary *documentPlistDic = [[NSMutableDictionary alloc] initWithContentsOfFile: bundle];
            NSData * data = [CPEncryption AES256EncryptWithKey:PLIST_PASSWORD data:documentPlistDic];
            [data writeToFile:plistPath atomically:YES];
            
            
        }else{
            NSMutableDictionary *documentPlistDic = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath]; //document(local) plist
            NSMutableDictionary *originPlistDic = [[NSMutableDictionary alloc] initWithContentsOfFile: bundle]; //origin plist

            if (![[documentPlistDic valueForKey:VERSION_KEY] isEqualToString:[originPlistDic valueForKey:VERSION_KEY]]) {
                NSLog(@"%@ 파일의 버전정보 변경! document version : %@, origin version : %@", fileName, [documentPlistDic valueForKey:VERSION_KEY], [originPlistDic valueForKey:VERSION_KEY]);
                
                if ([[originPlistDic objectForKey:RESET_KEY] isEqual:[NSNumber numberWithBool:YES]]) {
                    
                    //2. reset key가 YES면 기존 plist file 삭제 후 documents로 다시 copy
                    NSLog(@"리셋여부 YES! document 에서 %@ 파일삭제", fileName);
                    [fileManager removeItemAtPath:plistPath error:&error];
                    NSLog(@"document에 %@파일 재 copy", fileName);
//                    [fileManager copyItemAtPath:bundle toPath: plistPath error:&error];
                    NSMutableDictionary *documentPlistDic = [[NSMutableDictionary alloc] initWithContentsOfFile: bundle];
                    NSData * data = [CPEncryption AES256EncryptWithKey:PLIST_PASSWORD data:documentPlistDic];
                    [data writeToFile:plistPath atomically:YES];
                    
                }else{
                    [documentPlistDic setObject:[originPlistDic objectForKey: VERSION_KEY] forKey:VERSION_KEY];//버전 update
                    
                    //3. 새로운 키가 있다면 기존정보에 add
                    NSArray *originKeyList = [originPlistDic allKeys];
                    NSArray *documentKeyList = [documentPlistDic allKeys];
                    
                    BOOL isKey;//key 존재여부
                    
                    //origin에 새로 추가된 키를 document에 넣는다.
                    for (int i = 0; i < [originKeyList count]; i++) {
                        isKey = NO;
                        for (int j = 0; j < [documentKeyList count]; j++) {
                            if ([originKeyList[i] isEqualToString:documentKeyList[j]]) {
                                isKey = YES;
                                break;
                            }
                        }
                        if (!isKey) {
                            [documentPlistDic setObject:[originPlistDic objectForKey:originKeyList[i]] forKey:originKeyList[i]]; //add
                        }
                    }
                    
                    documentKeyList = [documentPlistDic allKeys];
                    
                    //origin에 삭제된 키가 있다면 document에서 삭제 한다.
                    for (int i = 0; i < [documentKeyList count]; i++) {
                        isKey = NO;
                        for (int j = 0; j < [originKeyList count]; j++) {
                            if ([documentKeyList[i] isEqualToString:originKeyList[j]]) {
                                isKey = YES;
                            }
                        }
                        if (!isKey) {
                            [documentPlistDic removeObjectForKey:documentKeyList[i]]; //delete
                        }
                    }
                    
//                    [documentPlistDic writeToFile:plistPath atomically:YES]; //save
                    NSData * data = [CPEncryption AES256EncryptWithKey:PLIST_PASSWORD data:documentPlistDic];
                    [data writeToFile:plistPath atomically:YES];
                }
            }

        }
        NSData *doumentData = [[NSData alloc] initWithContentsOfFile: plistPath]; //document(local) plist
        [plistTypeArr addObject:doumentData];
    }
    return self;
}

- (NSMutableDictionary *) getPlist:(PLIST_TYPE)_plistType {
    
    NSData *data = plistTypeArr[_plistType];
    NSLog(@"암호화상태 : %@", data);
    NSMutableDictionary * plistDic = [CPEncryption AES256DecryptWithKey:PLIST_PASSWORD data:data];
    NSLog(@"복호화 : %@", plistDic);
    return plistDic;
}

- (BOOL) savePlist:(PLIST_TYPE)_plistType{
    
    NSData *data = plistTypeArr[_plistType];
   
    NSString *fileName = PLIST_FILE_NAMES[PLIST_TYPE_SETTING];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistTpyePath = [documentsDirectory stringByAppendingPathComponent:fileName]; //저장위치
    
    return [data writeToFile:plistTpyePath atomically:YES];
//    return [plistDic writeToFile:plistTpyePath atomically:YES];
}




@end
