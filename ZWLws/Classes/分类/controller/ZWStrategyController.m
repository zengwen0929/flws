//
//  ZWStrategyController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/3.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWStrategyController.h"
#import "ZWPresentModel.h"
#import "ZWZhuanTiCell.h"
#import "ZWDuixiangModel.h"
#import "ZWChanels.h"
#import "ZWDuixiangCell.h"
#import "ZWDXFrame.h"

@interface ZWStrategyController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *presentArray;
@property (nonatomic,strong) NSMutableArray *duixiangArray;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ZWStrategyController
-(NSMutableArray *)duixiangArray{
    
    if (_duixiangArray== nil) {
        _duixiangArray =[NSMutableArray array];
    }
    return _duixiangArray;
}
-(NSMutableArray *)presentArray{
    
    if (_presentArray== nil) {
        _presentArray =[NSMutableArray array];
    }
    return _presentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-108)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self getData];
    [self getData1];
    
    
    
   
}
- (void)getData1{
    
    [NetworkHelper Get:duixiangURL parameter:nil success:^(id responseObject) {
  //      ZWLog(@"%@",responseObject[@"data"][@"channel_groups"][0]);
        NSArray *array = [ZWDuixiangModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"channel_groups"]];
        [self.duixiangArray addObjectsFromArray:array];
//
//        ZWDuixiangModel *m1 = self.duixiangArray[0];
//        ZWChanels *m = m1.channels[0];
//        NSLog(@"%@",m.name);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];
    
}


- (void)getData{
    
    [NetworkHelper Get:zhuantiURL parameter:nil success:^(id responseObject) {
       //     ZWLog(@"%@",responseObject[@"data"][@"collections"]);
        NSArray *array = [ZWPresentModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"collections"]];
        [self.presentArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];
    
}
#pragma mark - UITablviewDatasource;
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.duixiangArray.count +1;
    ZWLog(@"==%ld",self.duixiangArray.count);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return 1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 130;
    }

    else{
  
         ZWDuixiangModel *m  = self.duixiangArray[indexPath.section -1];
        ZWDXFrame *f =[[ZWDXFrame alloc] init];
        f.array = m.channels;
        return f.cellHeight;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,40)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 30)];
        lable.text = @"专题";
        lable.font = [UIFont systemFontOfSize:13];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(Screen_Width - 55, 5, 55, 30);
        [button setTitle:@"查看全部>" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [view addSubview:button];
        [view addSubview:lable];
        return view;
    }
    else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 30)];
        ZWDuixiangModel *m = self.duixiangArray[section-1];
        label.text = m.name;
    //    label.backgroundColor = [UIColor greenColor];
        [view addSubview:label];
        return view;
    }
    
}
- (void)buttonDidPress:(UIButton *)btn{

    NSLog(@"buttonDidPress");

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {

        ZWZhuanTiCell *cell = [ZWZhuanTiCell cellWithTableView:tableView];
        cell.array = self.presentArray;
        return cell;
    }
    
    else{
        ZWDuixiangCell *cell = [ZWDuixiangCell cellWithTableView:tableView];
        ZWDuixiangModel *m  = self.duixiangArray[indexPath.section -1];
        ZWDXFrame *f = [[ZWDXFrame alloc] init];
        f.array = m.channels;
        cell.array  = m.channels;
    
        return cell;
    }
}


@end
