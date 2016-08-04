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
+ (TTLog*)sharedLog;
- (void)log:(NSString *)fmt,...;
- (void)showLog;
- (void)close;
@end
