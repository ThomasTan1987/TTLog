//
//  TTLog.m
//  TutorTalk
//
//  Created by ThoamsTan on 16/8/3.
//  Copyright © 2016年 TutorABC. All rights reserved.
//

#import "TTLog.h"
#import <UIKit/UIKit.h>
@interface TTLog()
@end
@implementation TTLog
static TTLog *instance = nil;
+ (TTLog*)sharedLog
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TTLog alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxSize = 1024 * 1024;
    }
    return self;
}
- (NSString *)path
{
    if (!_path) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        _path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"vipa_debug.log"];
        [[[NSFileManager alloc] init] createFileAtPath:_path contents:nil attributes:nil];
    }
    return _path;
}
- (void)log:(NSString *)fmt,...
{
    if (self.enableLog) {
        va_list args;
        va_start(args, fmt);
        //写到文件
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.path];
        unsigned long long fileSize = [fileHandle seekToEndOfFile];
        if (fileSize > self.maxSize) {
            [fileHandle truncateFileAtOffset:fileSize/2];
        }
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MM-dd hh:mm:ss"];
        NSString *dateString = [format stringFromDate:[NSDate date]];
        NSString *logString = [[NSString alloc] initWithFormat:fmt arguments:args];
        
        
        [fileHandle writeData:[[NSString stringWithFormat:@"[%@] %@\n",dateString,logString] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
        va_end(args);
    }
}
#pragma private

@end
