//
//  TTLog.h
//  TutorTalk
//
//  Created by ThoamsTan on 16/8/3.
//  Copyright © 2016年 TutorABC. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LOG(...) [[TTLog sharedLog] log:__VA_ARGS__]
@interface TTLog : NSObject
@property(nonatomic,assign)BOOL enableLog;
@property(nonatomic,copy)NSString *path;
@property(nonatomic,assign)unsigned long long maxSize;
+ (TTLog*)sharedLog;
- (void)log:(NSString *)fmt,...;
@end
