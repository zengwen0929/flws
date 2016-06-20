//
//  ZWGoodsDetailViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/13.
//  Copyright © 2016年 zengwen. All rights reserved.
//
//http://api.liwushuo.com/v2/items/1005798/recommend?
#import "ZWGoodsDetailViewController.h"
#import "ZWXiangQingViewController.h"
#import "ZWDanPingViewController.h"
#import "ZWPinLunViewController.h"
#import "ZWDetailModel.h"


@interface ZWGoodsDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *titles2;
@property (nonatomic,strong) UIView *titlesView;
@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) UIScrollView *contentView;
@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,strong)UIButton *likeBtn;
@property (nonatomic,strong)UIButton *shareBtn;
@property (nonatomic,strong)UIButton *buyBtn;
@property (nonatomic,strong) ZWDetailModel *model;

@end

@implementation ZWGoodsDetailViewController

//-(NSMutableArray *)titles
//{
//    if (_titles == nil) {
//        _titles = [NSMutableArray array];
//    }
//    
//    return _titles;
//}
//-(NSMutableArray *)titles2
//{
//    if (_titles2 == nil) {
//        _titles2 = [NSMutableArray array];
//    }
//    
//    return _titles2;
//}
//-(NSMutableArray *)scrollButtonArr{
//    
//    if (!_scrollButtonArr) {
//        self.scrollButtonArr = [NSMutableArray array];
//    }
//    return _scrollButtonArr;
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles2 = @[@"单品",@"详情",@"评论"];
    [self setNavigationBar];
    [self getData];
    
    [self setupTitlesView];
    [self setBottomTabBar];
    
    // 初始化子控制器
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)getData{

    
    
    [NetworkHelper Get:[NSString stringWithFormat:danpingURL,self.ID] parameter:nil success:^(id responseObject) {
        ZWLog(@"url = %@",[NSString stringWithFormat:danpingURL,self.ID]);
        NSLog(@"%@",responseObject[@"data"]);
        //        NSArray * array = [ZWHotModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
        //        [self.dataArray addObjectsFromArray:array];
        //        //        ZWHotModel *m = _dataArray[0];
        //        //        ZWDataModel *model = m.data;
        //        //        NSLog(@"%@",m.type);
        //        //        NSLog(@"%@",model.name);
        //        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

    
    [NetworkHelper Get:[NSString stringWithFormat:xiangqingURL,self.ID] parameter:nil success:^(id responseObject) {
        ZWLog(@"url = %@",[NSString stringWithFormat:xiangqingURL,self.ID]);
     //   NSLog(@"%@",responseObject[@"data"]);
        ZWDetailModel *model = [ZWDetailModel objectWithKeyValues:responseObject[@"data"]];
        self.model = model;
        [self setupChildVces];
        

        [self setupContentView];
        NSLog(@"%@",model.image_urls);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

//设置导航栏
- (void)setNavigationBar{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
 ;
}
/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    for (int i = 0; i < self.titles2.count; i++) {
        
        if (i==0) {
            ZWDanPingViewController *d = [[ZWDanPingViewController alloc] init];
            d.ID =self.ID;
            d.model = self.model;
            [self addChildViewController:d];
        }
        if (i == 1) {
            ZWXiangQingViewController *x = [[ZWXiangQingViewController alloc] init];
            
            x.model = self.model;
            [self addChildViewController:x];
        }
        
         if (i == 2) {
            ZWPinLunViewController *p = [[ZWPinLunViewController alloc] init];
            p.ID = self.ID;
            [self addChildViewController:p];
            
            
        }
    }
    
    
    
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = 150;
    titlesView.height = 35;
    titlesView.y = 0;
    self.navigationItem.titleView = titlesView;
 
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
    
    CGFloat width = titlesView.width /3;
  
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.titles2.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:self.titles2[i] forState:UIControlStateNormal];
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
    NSLog(@"===%ld",self.childViewControllers.count);
    contentView.contentSize = CGSizeMake(contentView.width * 3, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}



#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
 

    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    // 让对应的顶部标题居中显示
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"--%s",__func__);
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
//    if (index == 3) {
//        index = 2;
//    }
    NSLog(@"index==%ld",index);
    ZWLog(@"%@",self.titlesView.subviews[index]);
    [self titleClick:self.titlesView.subviews[index]];
    
}

- (void)setBottomTabBar{
    
    
    UIView * view =  [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-108, Screen_Width, 44)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    self.likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, (Screen_Width - 22)/3 , 30)];
    
    [self.likeBtn setTitle:@"喜欢"forState:UIControlStateNormal];
    [self.likeBtn setImage:[UIImage imageNamed:@"baichuan_navigation_favorites_21x21_@2x"] forState:UIControlStateNormal];
    
    [self.likeBtn setImage:[UIImage imageNamed:@"content-details_like_selected_16x16_@3x"] forState:UIControlStateSelected];
    self.likeBtn.tag = 101;
    [self.likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.likeBtn];
    
    self.shareBtn = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width - 22)/3 +11, 5, (Screen_Width - 22)/3, 30)];
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn setImage:[UIImage imageNamed:@"baichuan_navigation_share_21x21_@2x"] forState:UIControlStateNormal];
    
    
    self.shareBtn.tag = 102;
    [self.shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.shareBtn];
    //    self.shareBtn.backgroundColor = [UIColor redColor];
    //
    self.buyBtn = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width - 22)/3 +(Screen_Width - 22)/3 +11 +1, 5, (Screen_Width - 22)/3, 30)];
    //    self.buyBtn.backgroundColor = [UIColor greenColor];
    [self.buyBtn setImage:[UIImage imageNamed:@"baichuan_navigation_comments_21x21_@2x"] forState:UIControlStateNormal];
    
    [self.buyBtn setTitle:@"去购买" forState:UIControlStateNormal];
    self.buyBtn.tag = 103;
    [self.buyBtn addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.buyBtn];
    
    
    
}


@end
