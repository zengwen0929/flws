//
//  ZWDanPingViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/15.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWDanPingViewController.h"
#import "XRCarouselView.h"
#import "ZWDetailModel.h"

@interface ZWDanPingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ZWDanPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self carouselView];
    
    
}

- (void)carouselView{
    
    // 创建header
    XRCarouselView *header = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 350)];
    header.backgroundColor = [UIColor greenColor];
    header.imageArray = self.model.image_urls;
    // 设置header
    self.tableView.tableHeaderView = header;
    
    
    [header setImageClickBlock:^(NSInteger index) {
        NSLog(@"%zd",index);

        
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    // 定义变量保存重用标记的值
    static NSString *identifier = @"cell";
    
    //    1.先去缓存池中查找是否有满足条件的Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //    2.如果缓存池中没有符合条件的cell,就自己创建一个Cell
    if (cell == nil) {
        //    3.创建Cell, 并且设置一个唯一的标记
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        NSLog(@"创建一个新的Cell");
    
    }
    cell.textLabel.text = [NSString stringWithFormat:@"新的Cell==%ld",indexPath.row];
    return cell;
}

- (void)getData{

//    
//    [NetworkHelper Get:[NSString stringWithFormat:danpingURL,self.ID] parameter:nil success:^(id responseObject) {
//        ZWLog(@"url = %@",[NSString stringWithFormat:danpingURL,self.ID]);
//        NSLog(@"%@",responseObject[@"data"]);
////        NSArray * array = [ZWHotModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
////        [self.dataArray addObjectsFromArray:array];
////        //        ZWHotModel *m = _dataArray[0];
////        //        ZWDataModel *model = m.data;
////        //        NSLog(@"%@",m.type);
////        //        NSLog(@"%@",model.name);
////        [self.collectionView reloadData];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//    
//    



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
