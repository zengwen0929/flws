//
//  ZWChoiceViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/2.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWChoiceViewController.h"
#import "XRCarouselView.h"
#import "ZWCarouselModel.h"
#import "ZWScrollCell.h"
#import "ZWPresentModel.h"
#import "ZWOther2ViewController.h"
#import "ZWDetailViewController.h"

#import "ZWPresentCell.h"
@interface ZWChoiceViewController ()<UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *dataImage;
@property (nonatomic,strong) NSMutableArray *dataID;
@property (nonatomic,strong) NSMutableArray *menuArray;
@property (nonatomic,strong) NSMutableArray *PresentArray;
@property (nonatomic,assign) NSInteger *page;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation ZWChoiceViewController

-(NSMutableArray *)dataID{
    if (_dataID == nil) {
        _dataID = [NSMutableArray array];
        
    }
    return _dataID;
    
}
-(NSMutableArray *)dataImage{
    if (_dataImage == nil) {
        _dataImage = [NSMutableArray array];
        
    }
    return _dataImage;
    
}
-(NSMutableArray *)menuArray{

    if (_menuArray== nil) {
        _menuArray =[NSMutableArray array];
        
    }

    return _menuArray;
}
-(NSMutableArray *)PresentArray{
    
    if (_PresentArray== nil) {
        _PresentArray =[NSMutableArray array];
        
    }
    
    return _PresentArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidSelect:) name:@"ButtonDidClickNotification" object:nil];
    [self getData];
    [self getData2];
    // 添加刷新控件
    [self setupRefresh];

}
- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData3)];
    // 自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreDatas)];
}
- (void)tabBarDidSelect:(NSNotification *)notification
{
    ZWOther2ViewController *other = [[ZWOther2ViewController alloc] init];
    other.ID = notification.userInfo[@"ButtonClickTag"];
    NSLog(@"%@",other.ID);
    [self.navigationController pushViewController:other animated:YES];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
}
#pragma mark - 最下面的cell数据
- (void)getMoreDatas{
    
    //"http://api.liwushuo.com/v2/channels/100/items?ad=1&gender=1&generation=1&limit=20&offset=%@"
    
    // 结束上啦
    [self.tableView.footer endRefreshing];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ad"] = @"1";
    params[@"gender"] = @"1";
    params[@"generation"] = @"1";
    params[@"limit"] = @"20";
    NSInteger page = self.page +20;
    params[@"offset"] = @(page);
 
    self.params = params;
    // 结束上啦
    [self.tableView.footer endRefreshing];
    [NetworkHelper Get:PresentURL parameter:self.params success:^(id responseObject) {
    //    ZWLog(@"%@",responseObject[@"data"][@"items"]);
        NSArray *array = [ZWPresentModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
        [self.PresentArray addObjectsFromArray:array];
    
        [self.tableView reloadData];
        self.page = page;
        [self.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
    }];
    
    
    
    
}

- (void)getData3{
    
    //"http://api.liwushuo.com/v2/channels/100/items?ad=1&gender=1&generation=1&limit=20&offset=%@"
    
    
    self.page = 0;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ad"] = @"1";
    params[@"gender"] = @"1";
    params[@"generation"] = @"1";
    params[@"limit"] = @"20";
    params[@"offset"] = @"0";
    
    self.params = params;
    // 结束上啦
    [self.tableView.footer endRefreshing];
    [NetworkHelper Get:PresentURL parameter:self.params success:^(id responseObject) {
        //    ZWLog(@"%@",responseObject[@"data"][@"items"]);
        NSArray *array = [ZWPresentModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
        [self.PresentArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        self.page = 0;
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.header endRefreshing];
    }];
    
    
    
    
}
#pragma mark - 滚动视图下面的第一个cell数据
- (void)getData2{
    
    [NetworkHelper Get:CellScrollURL parameter:nil success:^(id responseObject) {

        NSArray *array= [ZWCarouselModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"secondary_banners"]];
  //      ZWLog(@"%@",responseObject[@"data"][@"secondary_banners"]);
        [self.menuArray addObjectsFromArray:array];
     //   NSLog(@"image_url==%@",menuArray[0].image);

        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];

    
}

#pragma mark - 首页滚动视图数据
- (void)getData{

    [NetworkHelper Get:CarouselURL parameter:nil success:^(id responseObject) {
       
        NSArray *array= [ZWCarouselModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"banners"]];
       //  ZWLog(@"%@",responseObject[@"data"][@"banners"]);
        NSMutableArray *arrayM1 = [NSMutableArray array];
        NSMutableArray *arrayM2 = [NSMutableArray array];
        for (ZWCarouselModel *model in array) {
            [arrayM1 addObject:model.image_url];
            
            if (model.target_id ==nil) {
                [arrayM2 addObject:@"12"];
            }else{
            [arrayM2 addObject:model.target_id];
        
            }
        }
        
        self.dataImage = arrayM1;
        self.dataID = arrayM2;
        [self carouselView];

    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];


}

- (void)carouselView{

    // 创建header
    XRCarouselView *header = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 140, Screen_Width, 200)];
    header.backgroundColor = [UIColor greenColor];
    header.imageArray = self.dataImage;
    // 设置header
    self.tableView.tableHeaderView = header;
    
    
    [header setImageClickBlock:^(NSInteger index) {
        NSLog(@"%zd",index);
        ZWOther2ViewController *other = [[ZWOther2ViewController alloc] init];
        other.ID = self.dataID[index];
        NSLog(@"%@",other.ID);
        [self.navigationController pushViewController:other animated:YES];
        
    }];
   

}


#pragma mark - UITablviewDatasource;
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else{
        return self.PresentArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        return 100;
    } else  {
   
        return 180;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    }else {
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        ZWScrollCell *cell = [ZWScrollCell cellWithTableView:tableView];
        cell.array = self.menuArray;
        return cell;
    }else {
       
        ZWPresentCell *cell = [ZWPresentCell cellWithTableView:tableView];

        cell.Model = self.PresentArray[indexPath.row];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        ZWDetailViewController *detaiVc = [[ZWDetailViewController alloc] init];
        ZWPresentModel *model =self.PresentArray[indexPath.row];
        detaiVc.model = model;
        detaiVc.url = model.url;
        [self.navigationController pushViewController:detaiVc animated:YES];
    }



}

@end
