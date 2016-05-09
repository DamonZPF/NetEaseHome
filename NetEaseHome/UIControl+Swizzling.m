//
//  UIControl+Swizzling.m
//  NetEaseHome
//
//  Created by ZHOUPENGFEI on 16/4/29.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import "UIControl+Swizzling.h"
#import "HookUtility.h"
#import "MobClick.h"
@implementation UIControl (Swizzling)

+(void)load{
    
    SEL originalSelector = @selector(sendAction:to:forEvent:);
    SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
    
    [HookUtility  hookUtilityWith:[self class] originalSEL:originalSelector swizzleSEL:swizzledSelector];
}

-(void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{

    [self setupAction:action to:target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];
}

-(void)setupAction:(SEL)action to:(id)target forEvent:(UIEvent*)event{
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) { //只统计点击结束的点击
        NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:[self filePath]];
        NSString * className = NSStringFromClass([target class]);
        NSString * actionName = NSStringFromSelector(action);
        NSString * result = dict[className][@"ControlEvent"][actionName];
        if (result) {
              [MobClick event:result];
        }
        NSLog(@"%@",result);
    }
}

-(NSString*)filePath{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"Event" ofType:@"plist"];
    return  filePath;
}

@end
