//
//  ZWPresentViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/5/27.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWPresentViewController.h"
#import "ZWPullModel.h"
#import "ZWChoiceViewController.h"
#import "ZWOtherViewController.h"



@interface ZWPresentViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *pullButton;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSMutableArray *titles2;
@property (nonatomic,strong) NSMutableArray *scrollButtonArr;
@property (nonatomic,strong) UIScrollView *contentView;
@property (nonatomic,strong) UIScrollView *titlesView;
@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) UIButton *selectedButton;
@end

@implementation ZWPresentViewController
-(NSMutableArray *)titles
{
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }

    return _titles;
}
-(NSMutableArray *)titles2
{
    if (_titles2 == nil) {
        _titles2 = [NSMutableArray array];
    }
    
    return _titles2;
}
-(NSMutableArray *)scrollButtonArr{
    
    if (!_scrollButtonArr) {
        self.scrollButtonArr = [NSMutableArray array];
    }
    return _scrollButtonArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBar];
    // 初始化子控制器
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self getButtonTitleData];
  
    [self createPullDownButton];
 
    
    

   
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    for (int i = 0; i < self.titles2.count; i++) {
       
        if (i==0) {
            ZWChoiceViewController *choiceVc = [[ZWChoiceViewController alloc] init];
            choiceVc.ID =self.titles2[i];
            [self addChildViewController:choiceVc];
        }
        else{
            ZWOtherViewController *otherVc = [[ZWOtherViewController alloc] init];
            otherVc.ID = self.titles2[i];
            [self addChildViewController:otherVc];
 
        
        }
    }
   
    
 
}
- (void)getButtonTitleData{
    [NetworkHelper Get:scrollButtonTitle parameter:nil success:^(id responseObject) {
      //  ZWLog(@"%@",responseObject[@"data"][@"channels"]);
        NSArray *array= [ZWPullModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"channels"]];
        NSMutableArray *arrayM1 = [NSMutableArray array];
        for (ZWPullModel *model in array) {
            [arrayM1 addObject:model.name];
        }
        self.titles = arrayM1;
        NSMutableArray *arrayM2 = [NSMutableArray array];
        for (ZWPullModel *model in array) {
            [arrayM2 addObject:model.ID];
        }
        self.titles2 = arrayM2;

        ZWLog(@"titles.count===%ld",self.titles.count);
        [self setupChildVces];
        [self setupTitlesView];
        [self setupContentView];
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];

}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width-30;
    titlesView.height = 35;
    titlesView.y = 0;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    //    ZWLog(@"===%ld",self.titles.count);
    // 内部的子标签
   
    CGFloat width = titlesView.width /5.3;
    self.titlesView.contentSize = CGSizeMake(self.titles.count * width, 0);
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
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
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark -------------------pullbutton--------------------------
- (void)createPullDownButton {
    self.pullButton = [UIButton buttonWithType:UIButtonTypeCustom];
  //  self.pullButton.backgroundColor = [UIColor greenColor];
    
    self.pullButton.userInteractionEnabled = YES;
    self.pullButton.frame = CGRectMake(Screen_Width - 30, 0, 30, 30);
    [self.pullButton setImage:[UIImage imageNamed:@"giftcategorydetail_arrow_down_gray_6x3_@3x"] forState:UIControlStateNormal];
    [self.pullButton setImage:[UIImage imageNamed:@"giftcategorydetail_arrow_up_gray_6x3_@3x"] forState:UIControlStateSelected];
    [self.pullButton addTarget:self action:@selector(toPullViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pullButton];
}


- (void)toPullViewController:(UIButton *)pull{

    ZWLog(@"pull");

}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"--%s",__func__);
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    // 让对应的顶部标题居中显示
    UIButton *label = self.titlesView.subviews[index+2];
    CGPoint titleOffset = self.titlesView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titlesView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX+20;
    
    [self.titlesView setContentOffset:titleOffset animated:YES];

    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"--%s",__func__);
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;

    //ZWLog(@"--%@",self.titlesView.subviews[index+2]);
    //scrollView内部有两个imageView子控件所有需要加2
    [self titleClick:self.titlesView.subviews[index+2]];
    
}

//设置导航栏
- (void)setNavigationBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"礼物说";
}

@end
