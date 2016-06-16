//
//  ZWDetailViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/8.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWDetailViewController.h"
#import "ZWPresentModel.h"
#import "ZWCommentsController.h"
#import "MTDealTool.h"

@interface ZWDetailViewController ()
@property (nonatomic,strong)UIButton *likeBtn;
@property (nonatomic,strong)UIButton *shareBtn;
@property (nonatomic,strong)UIButton *buyBtn;
@property (nonatomic,assign) NSInteger *count;



@end

@implementation ZWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.translatesAutoresizingMaskIntoConstraints  = NO;
    [self setUpWebView];
    
    [self setBottomTabBar];
    
    // 设置收藏状态
    self.likeBtn.selected = [MTDealTool isCollected:self.model];
    
    
    
}

- (void)setBottomTabBar{
    
    
    UIView * view =  [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-108, Screen_Width, 44)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    self.likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, (Screen_Width - 22)/3 , 30)];
    
    [self.likeBtn setTitle:@"收藏"forState:UIControlStateNormal];
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
    
    [self.buyBtn setTitle:@"评论" forState:UIControlStateNormal];
    self.buyBtn.tag = 103;
    [self.buyBtn addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.buyBtn];
    
    
    
}


- (void)setUpWebView{
    NSURL *url = [NSURL URLWithString:self.url];
    //3.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //浏览器
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-108)];
    
    
    [webView loadRequest:request];
    
    webView.scalesPageToFit = YES; //自动拉伸
    
    [self.view addSubview:webView];
    
    
    
}

- (void)buyClick:(UIButton *)btn{
    
    NSLog(@"评论");
    ZWCommentsController *commentVC = [[ZWCommentsController alloc] init];
    ZWPresentModel *m = self.model;
    commentVC.ID = m.ID;
    [self.navigationController pushViewController:commentVC animated:YES];
    
    
}

- (void)btnClick:(UIButton *)btn{
    
    ZWPresentModel *m = self.model;
    
    if (self.likeBtn.isSelected) { // 取消收藏
        [MTDealTool removeCollectDeal:m];
        [MBProgressHUD showSuccess:@"取消收藏成功" toView:self.view];
        
    } else { // 收藏
        [MTDealTool addCollectDeal:m];
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
        
    }
    
    // 按钮的选中取反
    self.likeBtn.selected = !self.likeBtn.isSelected;
    
  
    
}

- (void)shareClick:(UIButton *)btn{
    
    NSLog(@"btn = %ld",btn.tag);
    
    
    
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
