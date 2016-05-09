//
//  HookUtility.h
//  NetEaseHome
//
//  Created by ZHOUPENGFEI on 16/4/29.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HookUtility : NSObject

+(void)hookUtilityWith:(Class)class originalSEL:(SEL)originalSEL swizzleSEL:(SEL)swizzleSEL;

@end
