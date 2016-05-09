//
//  ViewController.m
//  NetEaseHome
//
//  Created by ZHOUPENGFEI on 16/4/28.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
#import "UIViewController+Swizzling.h"
#import "CustomLabel.h"

static const CGFloat titleLabelWith = 100;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *headScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/** data */
@property(nonatomic,strong) NSMutableArray *  titleData;
@end

@implementation ViewController

-(NSMutableArray*)titleData{
    
    if (_titleData == nil) {
        NSArray * array = @[@"头条",@"热点",@"娱乐",@"体育",@"财经",@"科技",@"汽车",@"时尚",@"杭州"];
        return [array mutableCopy];
    }
    return _titleData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHeadView];
    [self setupViewControllers];
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];

}




- (IBAction)nextAction:(UIBarButtonItem *)sender {
    
    NSLog(@"nextAction");
    
}


-(void)setupHeadView{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW  = titleLabelWith;
    CGFloat titleH = self.headScrollView.bounds.size.height;
    for (NSInteger index = 0; index < self.titleData.count; index++) {
        CustomLabel * titleLabel = [[CustomLabel alloc] init];
        titleLabel.text = self.titleData[index];
        titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
        [titleLabel  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        titleLabel.tag = index;
        [self.headScrollView addSubview:titleLabel];
        titleX += titleW;
    }
    
    self.headScrollView.contentSize = CGSizeMake(titleW * self.titleData.count, 0);
    self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.titleData.count, 0);
}

-(void)tap:(UITapGestureRecognizer*)tap{

    UILabel * titleLabel = (UILabel*)tap.view;
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.contentScrollView.bounds.size.width * titleLabel.tag;
    [self.contentScrollView setContentOffset:offset animated:YES];
    
}

-(UIColor*)randColor{

    return  [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    
}

-(void)setupViewControllers{

    for (NSInteger index = 0; index < self.titleData.count; index++) {
        SubViewController * subVC = [[SubViewController alloc] init];
        subVC.title = self.titleData[index];
        [self addChildViewController:subVC];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat scale = self.contentScrollView.contentOffset.x / self.contentScrollView.bounds.size.width;

    NSInteger leftIndex = scale;
    CustomLabel * leftLabel = self.headScrollView.subviews[leftIndex];
    

    NSInteger rightIndex = leftIndex + 1;
    if (rightIndex >=self.headScrollView.subviews.count) {
        return;
    }
    CustomLabel * rightLabel = self.headScrollView.subviews[rightIndex];
  
    CGFloat rightScale =  scale - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
    
}



//手势触发

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

//设置   [self.contentScrollView setContentOffset:offset animated:YES]; 触发
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = self.contentScrollView.contentOffset.x / self.contentScrollView.bounds.size.width;
   
    
    UILabel * titleLabel = self.headScrollView.subviews[index];
    CGPoint headOffset = self.headScrollView.contentOffset;
    headOffset.x = titleLabel.center.x - self.contentScrollView.frame.size.width * 0.5;
    
    if (headOffset.x < 0) {
        headOffset.x = 0;
    }
    CGFloat maxOffset = self.headScrollView.contentSize.width - self.headScrollView.frame.size.width;
    if (headOffset.x > maxOffset) {
        headOffset.x = maxOffset;
    }
    
    [self.headScrollView setContentOffset:headOffset animated:YES];
    
    
    SubViewController * subVC = self.childViewControllers[index];
    if ([subVC isViewLoaded]) {//判断控制器是否已经加载过
        return;
    }
    
    subVC.view.frame = CGRectMake(index * self.contentScrollView.bounds.size.width,0, self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:subVC.view];

}


@end
