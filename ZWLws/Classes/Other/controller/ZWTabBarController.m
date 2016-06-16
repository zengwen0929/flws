//
//  ZWTabBarController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/5/27.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWTabBarController.h"
#import "ZWHotViewController.h"
#import "ZWMineViewController.h"
#import "ZWPresentViewController.h"
#import "ZWClassifyViewController.h"
#import "ZWNavigationController.h"


@interface ZWTabBarController ()

@end

@implementation ZWTabBarController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UINavigationBar appearance];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[ZWPresentViewController alloc] init] title:@"礼物说" image:@"tabbar_home_22x22_@2x" selectedImage:@"tabbar_home_selected_22x22_@2x"];
    
    [self setupChildVc:[[ZWHotViewController alloc] init] title:@"热门" image:@"tabbar_gift_22x22_@2x" selectedImage:@"tabbar_gift_selected_22x22_@2x"];
    
    [self setupChildVc:[[ZWClassifyViewController alloc] init] title:@"分类" image:@"tabbar_category_22x22_@2x" selectedImage:@"tabbar_category_selected_22x22_@2x"];
    
    [self setupChildVc:[[ZWMineViewController alloc] init] title:@"我的" image:@"tabbar_me_22x22_@2x" selectedImage:@"tabbar_me_selected_22x22_@2x"];
 
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    //  childVc.title = title; // 同时设置tabbar和navigationBar的文字
    childVc.tabBarItem.title = title; // 设置tabbar的文字
    //    childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //childVc.view.backgroundColor = HWRandomColor;    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    ZWNavigationController *nav = [[ZWNavigationController alloc] initWithRootViewController:childVc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];
}
@end
