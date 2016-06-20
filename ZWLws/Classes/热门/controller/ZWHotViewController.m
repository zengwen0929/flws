//
//  ZWHotViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/5/27.
//  Copyright © 2016年 zengwen. All rights reserved.
//
#define url @"http://api.liwushuo.com/v2/items?gender=1&generation=4&limit=50&offset=0"
#import "ZWHotViewController.h"
#import "ZWHotModel.h"
#import "ZWDataModel.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "ZWGoodsCollectionViewCell.h"
#import "ZWGoodsDetailViewController.h"


@interface ZWHotViewController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ZWHotViewController
-(NSMutableArray *)dataArray{

    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }

    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self getData2];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建瀑布流布局,每个item的大小,都是动态设置的
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    //设置列数
    layout.columnCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    //创建UICollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZWGoodsCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = Screen_Width/2;
    CGFloat height = 215; //实际上应该从服务器中获取
    
    return CGSizeMake(width, height);
}


#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZWGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ZWHotModel *model = self.dataArray[indexPath.item];
    
    [cell.imagView sd_setImageWithURL:[NSURL URLWithString:model.data.cover_image_url] placeholderImage:nil];
    cell.nameLabel.text = model.data.name;
    cell.nameLabel.textAlignment = NSTextAlignmentLeft;
    cell.nameLabel.numberOfLines = 0;
    
    cell.nameLabel.font = [UIFont systemFontOfSize:12];
    
    cell.PriceLabel.text = [NSString stringWithFormat:@"￥%@",model.data.price];
    cell.PriceLabel.textColor = [UIColor redColor];

    
    cell.PriceLabel.font = [UIFont systemFontOfSize:14];
   // cell.likeBtn.backgroundColor =[UIColor greenColor];
    [cell.likeBtn setImage:[UIImage imageNamed:@"icon_favorite_topitem_12x10_@3x"] forState:UIControlStateNormal];
    [cell.likeBtn setTitle:model.data.favorites_count forState:UIControlStateNormal];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWGoodsDetailViewController *GVC = [[ZWGoodsDetailViewController alloc] init];
     ZWHotModel *model = self.dataArray[indexPath.item];
    ZWDataModel *m =model.data;
    GVC.ID = m.ID;
    [self.navigationController pushViewController:GVC animated:YES];
    

}
- (void)getData2{
    
    [NetworkHelper Get:url parameter:nil success:^(id responseObject) {
      //  NSLog(@"%@",responseObject[@"data"][@"items"]);
        NSArray * array = [ZWHotModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
        [self.dataArray addObjectsFromArray:array];
//        ZWHotModel *m = _dataArray[0];
//        ZWDataModel *model = m.data;
//        NSLog(@"%@",m.type);
//        NSLog(@"%@",model.name);
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
}

//设置导航栏
- (void)setNavigationBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"热门";
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
