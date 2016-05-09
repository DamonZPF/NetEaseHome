//
//  UIViewController+Swizzling.m
//  NetEaseHome
//
//  Created by ZHOUPENGFEI on 16/4/29.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "HookUtility.h"
#import "MobClick.h"
@implementation UIViewController (Swizzling)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL origselAppear = @selector(viewWillAppear:);
        SEL swizselAppear = @selector(swiz_viewWillAppear:);
        [HookUtility hookUtilityWith:[self class] originalSEL:origselAppear swizzleSEL:swizselAppear];
        
        SEL origselDis = @selector(viewWillDisappear:);
        SEL swizzlDis = @selector(swiz_viewWillDisappear:);
        
        [HookUtility hookUtilityWith:[self class] originalSEL:origselDis swizzleSEL:swizzlDis];
    });
}


-(void)swiz_viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    [self swiz_viewWillAppear:animated];
}

-(void)swiz_viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [self swiz_viewWillDisappear:animated];
}

@end
