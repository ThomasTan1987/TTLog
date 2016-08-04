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
@property (nonatomic, strong)NSMutableString *logText;
@property (nonatomic, strong)UIView *logView;
@property (nonatomic, strong)UITextView *textView;
@end
@implementation TTLog
static TTLog *instance = nil;
+ (TTLog*)sharedLog
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TTLog alloc] init];
        instance.logText = [[NSMutableString alloc] init];
    });
    return instance;
}
- (void)log:(NSString *)fmt,...
{
    va_list args;
    va_start(args, fmt);
    //写到文件
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd hh:mm:ss"];
    NSString *dateString = [format stringFromDate:[NSDate date]];
    NSString *logString = [[NSString alloc] initWithFormat:fmt arguments:args];
    
    [self.logText appendFormat:@"[%@] %@\n",dateString,logString];
    va_end(args);
}
- (void)showLog
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!self.logView) {
        self.logView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [window addSubview:self.logView];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:self.logView.bounds];
        self.textView = textView;
        textView.text = self.logText;
        [self.logView addSubview:textView];
        textView.editable = NO;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor grayColor];
        button.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, 50, 30);
        [self.logView addSubview:button];
        [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnReset setTitle:@"清除" forState:UIControlStateNormal];
        btnReset.backgroundColor = [UIColor grayColor];
        btnReset.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height - 50, 50, 30);
        [self.logView addSubview:btnReset];
        [btnReset addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    }
    [window addSubview:self.logView];
}
- (void)reset
{
    self.logText = nil;
    self.textView.text = @"";
}
- (void)close
{
    [self.logView removeFromSuperview];
}
#pragma private 

@end
