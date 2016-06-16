//
//  ZWMineViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/5/27.
//  Copyright © 2016年 zengwen. All rights reserved.
//


#import "ZWMineViewController.h"
#import "ZWDetailViewController.h"
#import "ZWBtnCell.h"
#import "ZWPresentModel.h"
#import "MTDealTool.h"
#import "ZWPresentCell.h"



CGFloat const MJMinionInitH = 320;

CGFloat const MJInsetTop = 150;

@interface ZWMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UIImageView *minionView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *deals;
@property (nonatomic, assign) int currentPage;

@end

@implementation ZWMineViewController

- (NSMutableArray *)deals
{
    if (!_deals) {
        self.deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}
- (void)viewWillAppear:(BOOL)animated{

    

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)zhumoxinshuju:(NSNotification *)info{

    NSLog(@"%@",info.userInfo[@"title"]);


}

- (void)viewDidLoad
{
    [super viewDidLoad];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhumoxinshuju:) name:@"shoucangNotification" object:nil];
    
    self.navigationController.navigationBarHidden = YES;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    UIButton *emailView  =  [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 20, 20)];
    [emailView setBackgroundImage:[UIImage imageNamed:@"me_message_20x20_@3x"] forState:UIControlStateNormal];
    emailView.tag = 101;
    [emailView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailView];
    
    UIButton *emailView2  =  [[UIButton alloc]initWithFrame:CGRectMake(60, 30, 20, 20)];
    [emailView2 setBackgroundImage:[UIImage imageNamed:@"me_giftremind_19x18_@2x"] forState:UIControlStateNormal];
    emailView2.tag = 102;
    [emailView2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailView2];
    UIButton *emailView3  =  [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-80, 30, 20, 20)];
    [emailView3 setBackgroundImage:[UIImage imageNamed:@"me_scan_20x20_@2x"] forState:UIControlStateNormal];
    emailView3.tag = 103;
    [emailView3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailView3];
    UIButton *emailView4  =  [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-40, 30, 20, 20)];
  //  emailView4.backgroundColor = [UIColor greenColor];
    [emailView4 setBackgroundImage:[UIImage imageNamed:@"iconSettings_18x18_@1x"] forState:UIControlStateNormal];
    emailView4.tag = 104;
    [emailView4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailView4];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(MJInsetTop, 0, 0, 0);
    
    UIImageView *minionView = [[UIImageView alloc] init];
    minionView.image = [UIImage imageNamed:@"me_profilebackground@2x.jpg"];
    UIImageView * imagelog = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width/2-40, 200, 80, 80)];
    imagelog.image = [UIImage imageNamed:@"me_avatarplaceholder_75x75_@2x"];
    [minionView addSubview:imagelog];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-40, 280, 80, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"登录";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    [minionView addSubview:label];
    
    minionView.frame = CGRectMake(0, -MJMinionInitH, Screen_Width, MJMinionInitH);
    minionView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:minionView atIndex:0];
   // self.tableView.tableHeaderView = minionView;
    self.minionView = minionView;
  
    
    // 加载第一页的收藏数据
    [self loadMoreDeals];
   
}



- (void)loadMoreDeals
{
    // 1.增加页码
    self.currentPage++;
    
    // 2.增加新数据
    [self.deals addObjectsFromArray:[MTDealTool collectDeals:self.currentPage]];
    
    // 3.刷新表格
    [self.tableView reloadData];
    

}
-(void)btnClick:(UIButton *)btn{
    NSLog(@"11111");
   
    
    
    
  
}


-(void)click:(UIButton *)btn{

    NSLog(@"%@",btn.titleLabel.text);

 
    

}
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else{
        return self.deals.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZWBtnCell *cell = [ZWBtnCell cellWithTableView:tableView];
        return cell;
    }else{
        ZWPresentCell *cell = [ZWPresentCell cellWithTableView:tableView];
        cell.Model = self.deals[indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 80;
    }
    else{
    
        return 180;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    if (section == 1) {
        return 40;
    }
    else{
        return 1;
    
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
        view.backgroundColor = [UIColor redColor];
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/2, 50)];
        [btn1 setTitle:@"喜欢的礼物"forState:UIControlStateNormal];
        btn1.tag = 1;
        btn1.userInteractionEnabled = YES;
        [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn1];
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width/2,0, Screen_Width/2, 50)];
        btn2.tag = 2;
        [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitle:@"喜欢的攻略"forState:UIControlStateNormal];
        btn2.userInteractionEnabled = YES;
        [view addSubview:btn2];
       return  view;
    }
    return nil;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算往下拽的距离
    CGFloat dragDelta = - MJInsetTop - scrollView.contentOffset.y;
    if (dragDelta < 0) dragDelta = 0;
    self.minionView.height = MJMinionInitH + dragDelta;
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
