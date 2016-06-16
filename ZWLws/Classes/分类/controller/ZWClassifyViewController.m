//
//  ZWClassifyViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/5/27.
//  Copyright © 2016年 zengwen. All rights reserved.
//


#import "ZWClassifyViewController.h"
#import "ZWStrategyController.h"
#import "ZWGiftController.h"

@interface ZWClassifyViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic,strong)  UIScrollView *contentView;
@end

@implementation ZWClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self segmentedControls];
    [self setupChildVces];
    [self setupContentView];
    

}
- (void)setupChildVces
{
    ZWStrategyController *strstageVc = [[ZWStrategyController alloc] init];
    
    [self addChildViewController:strstageVc];
    
    ZWGiftController *giftVc = [[ZWGiftController alloc] init];
    
    [self addChildViewController:giftVc];
    
}
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    NSLog(@"count ==%ld",self.childViewControllers.count);
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)segmentedControls {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"攻略", @"礼物"]];
    self.navigationItem.titleView = self.segmentedControl;
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.frame = CGRectMake(0, 0, 150, 20);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.segmentedControl.layer.cornerRadius = 2;
    self.segmentedControl.layer.masksToBounds = YES;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlDidPress:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentedControlDidPress:(UISegmentedControl *)sender {
    
  //  [self scrollViewDidEndScrollingAnimation:self.contentView];
        if (sender.selectedSegmentIndex == 1) {
            self.contentView.contentOffset = CGPointMake(self.view.width, 0);
             [self scrollViewDidEndScrollingAnimation:self.contentView];
        }else {
            self.contentView.contentOffset = CGPointMake(0, 0);
        }
    
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"--滚动%s",__func__);

    NSInteger index = scrollView.contentOffset.x / scrollView.width;
  
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
      [self scrollViewDidEndScrollingAnimation:scrollView];
        if (self.contentView.contentOffset.x == 0) {
            self.segmentedControl.selectedSegmentIndex = 0;
        }else {
            self.segmentedControl.selectedSegmentIndex = 1;
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
