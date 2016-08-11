//
//  TTLog.h
//  TutorTalk
//
//  Created by ThoamsTan on 16/8/3.
//  Copyright © 2016年 TutorABC. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG
#define LOG(...) [[TTLog sharedLog] log:__VA_ARGS__]
#define SHOW_LOG [[TTLog sharedLog] showLog]
#else
#define LOG(...)
#define SHOW_LOG
#endif
@interface TTLog : NSObject
+ (TTLog*)sharedLog;
- (void)log:(NSString *)fmt,...;
- (void)showLog;
- (void)close;
@end
