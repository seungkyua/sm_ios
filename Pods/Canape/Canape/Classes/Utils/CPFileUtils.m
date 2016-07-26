//
//  CPFileUtils.m
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

#import "CPFileUtils.h"

@implementation CPFileUtils


+(BOOL)createDirectory:(NSString *)directory {
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:directory];
    
    NSError *error;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error])
        {
            NSLog(@"Create Directory ERROR : %@", error);
            return NO;
        }
    }
    return YES;
}

+(BOOL)removeDirectory:(NSString *)directory {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *filePath;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:directory];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        if ([fileManager removeItemAtPath:filePath error:NULL] == NO){
            NSLog(@"Remove Directory ERROR");
            return NO;
        }
    }
    return YES;
}

+(NSArray *)getFileList:(NSString *)directory {
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *filePath;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:directory];
    
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath: filePath error:NULL];
    NSLog(@"%@", fileList);
    return fileList;
}

@end
