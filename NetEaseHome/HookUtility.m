//
//  HookUtility.m
//  NetEaseHome
//
//  Created by ZHOUPENGFEI on 16/4/29.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import "HookUtility.h"
#import <objc/runtime.h>
@implementation HookUtility
+(void)hookUtilityWith:(Class)class originalSEL:(SEL)originalSEL swizzleSEL:(SEL)swizzleSEL{
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSEL);
    
    BOOL isAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (isAddMethod) {
        class_replaceMethod(class, swizzleSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    }else{
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
    
}
@end
