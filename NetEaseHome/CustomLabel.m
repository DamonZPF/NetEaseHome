//
//  CustomLabel.m
//  NetEaseHome
//
//  Created by ZHOUPENGFEI on 16/5/3.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import "CustomLabel.h"
#import "Const.h"
@implementation CustomLabel

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
     
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.textColor = [UIColor colorWithRed:kRed green:kGreen blue:kBlue alpha:kAlpha];
    }
    return self;
}

-(void)setScale:(CGFloat)scale{
    _scale = scale;
    
    CGFloat red = kRed + (1 - kRed)*scale;
    CGFloat blue = kBlue + (0-kBlue)*scale;
    CGFloat green = kGreen + (0 - kGreen)*scale;
    self.textColor = [UIColor colorWithRed:red green:blue blue:green alpha:kAlpha];
    
    CGFloat s = 1 + scale * 0.2;
    self.transform = CGAffineTransformMakeScale(s, s);
}

@end
