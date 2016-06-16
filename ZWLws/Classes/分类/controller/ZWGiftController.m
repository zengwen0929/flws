//
//  ZWGiftController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/3.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWGiftController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "ZWChanels.h"
#import "ZWClassCollectionViewCell.h"
#import "ZWSubcategories.h"

@interface ZWGiftController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong) NSMutableArray *titlename;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSArray *subArray;
@property (nonatomic,strong) UIScrollView  *scrollview;
@property (nonatomic,retain) UICollectionView  *coll;

@property (nonatomic,assign)  NSInteger row;
@property (nonatomic,assign) NSInteger  a;

@property (nonatomic,assign) NSInteger  b;
@end

@implementation ZWGiftController
-(NSArray *)subArray{
    
    if (_subArray == nil) {
        _subArray  = [NSArray array];
        
    }
    return _subArray;
}

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray  = [NSMutableArray array];
        
    }
    return _dataArray;
}
-(NSMutableArray *)titlename{
    
    if (_titlename == nil) {
        _titlename  = [NSMutableArray array];
        
    }
    return _titlename;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    _scrollview.directionalLockEnabled=YES;
    _scrollview.contentSize=CGSizeMake(Screen_Width, Screen_Height);
    _scrollview.delegate=self;
    
  
    [self.view addSubview:self.scrollview];
    [self setdeatil];
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, Screen_Height-108)];
    _table.delegate=self;
    _table.dataSource=self;
    [self.scrollview addSubview:_table];
    _a=1;
    _b=1;
    
}

- (void)setcollelction{
    
    UICollectionViewFlowLayout*flow1=[[UICollectionViewFlowLayout alloc]init];
    
    //列距
    
    flow1.minimumInteritemSpacing=10;
    //行距
    
    flow1.minimumLineSpacing=30;
    //分区内边距
    
    flow1.sectionInset=UIEdgeInsetsMake(0, 10, 10, 10);
    CGFloat totalwidth=self.view.frame.size.width;
    
    CGFloat itemwideth1=(totalwidth-2*10-2*10 )/3.0;
    CGFloat itemh=itemwideth1;
    
    flow1.itemSize=CGSizeMake(itemwideth1, itemh);
    
    flow1.headerReferenceSize=CGSizeMake(0, 50);
    //滚动方向
    flow1.scrollDirection=UICollectionViewScrollDirectionVertical;
    //区头大小
    
    flow1.headerReferenceSize=CGSizeMake(0, 30);
    _coll=[[UICollectionView alloc]initWithFrame:CGRectMake(100,0, Screen_Width-100, Screen_Height-108) collectionViewLayout:flow1];
    _coll.dataSource=self;
    _coll.delegate=self;
    [_coll registerClass:[ZWClassCollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];
    _coll.backgroundColor=[UIColor whiteColor];
    
    
    for (NSString*St in _titlename) {
        
        [_coll registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:St];
    }
    [self.scrollview addSubview:_coll];

}
- (void)setdeatil{
    
    [NetworkHelper Get:@"http://api.liwushuo.com/v2/item_categories/tree" parameter:nil success:^(id responseObject) {
        //ZWLog(@"%@",responseObject[@"data"][@"categories"]);
        NSArray *array = [ZWChanels objectArrayWithKeyValuesArray:responseObject[@"data"][@"categories"]];
        [self.dataArray addObjectsFromArray:array];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (ZWChanels *model in array) {
            [arrayM addObject:model.name];
        }
        self.titlename = arrayM;
        
        [self.table reloadData];
        
        [self setcollelction];
        
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titlename.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* ide=@"cell";
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ide];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ide];
    }
    cell.textLabel.text=_titlename[indexPath.row];
    
    cell.textLabel.textColor=[UIColor blackColor];
    cell.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.3];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        _a=indexPath.row;
        NSIndexPath*dex=[NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    
        [self.coll scrollToItemAtIndexPath:dex atScrollPosition:(UICollectionViewScrollPositionTop) animated:NO];
    
        [_table scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _titlename.count;

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    ZWChanels *m = self.dataArray[section];
    self.subArray = m.subcategories;
    
    return self.subArray.count;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ZWClassCollectionViewCell*cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    ZWChanels  *model=self.dataArray[indexPath.section];
    ZWSubcategories *model1  = model.subcategories[indexPath.item];
    cell1.model=model1;
    return cell1;

}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionReusableView*header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:_titlename[indexPath.section] forIndexPath:indexPath];
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(header.frame.size.width/2-100, 20, 200, 18)];
    label.text=_titlename[indexPath.section];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    //label.backgroundColor = [UIColor redColor];
    [header addSubview:label];
    
    
    return header;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(0,50);
    
}



- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //在didenddisplay 执行完之后在执行;
    _b=_a;

}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

        NSArray*arr=[NSArray array];
        arr=[_coll indexPathsForVisibleItems];
        if (arr.count>0) {

            if (_a!=_b) {

                NSIndexPath*dex3=[NSIndexPath indexPathForRow:_row inSection:0];
                UITableViewCell*cell3=(UITableViewCell*)[_table cellForRowAtIndexPath:dex3];

                cell3.textLabel.textColor=[UIColor blackColor];
                cell3.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.3];



                NSIndexPath*dex=[NSIndexPath indexPathForRow:_a inSection:0];


                NSIndexPath*dex1=[NSIndexPath indexPathForRow:_b inSection:0];
                UITableViewCell*cell=(UITableViewCell*)[_table cellForRowAtIndexPath:dex1];

                cell.textLabel.textColor=[UIColor blackColor];
                cell.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.3];


                UITableViewCell*cell1=(UITableViewCell*)[_table cellForRowAtIndexPath:dex];
                cell1.textLabel.textColor=[UIColor redColor];
                cell1.backgroundColor=[UIColor whiteColor];

                [_table scrollToRowAtIndexPath:dex atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
                _row=_b;

            }else{

                NSIndexPath*p=arr[0];
                NSLog(@"%@",p);
                NSIndexPath*dex2=[NSIndexPath indexPathForRow:_b inSection:0];
                UITableViewCell*cell2=(UITableViewCell*)[_table cellForRowAtIndexPath:dex2];

                cell2.textLabel.textColor=[UIColor blackColor];
                cell2.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.3];

                NSIndexPath*dex=[NSIndexPath indexPathForRow:p.section inSection:0];

                NSIndexPath*dex1=[NSIndexPath indexPathForRow:_row inSection:0];
                UITableViewCell*cell=(UITableViewCell*)[_table cellForRowAtIndexPath:dex1];

                cell.textLabel.textColor=[UIColor blackColor];
                cell.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.3];

                UITableViewCell*cell1=(UITableViewCell*)[_table cellForRowAtIndexPath:dex];
                cell1.textLabel.textColor=[UIColor redColor];
                cell1.backgroundColor=[UIColor whiteColor];

                [_table scrollToRowAtIndexPath:dex atScrollPosition:(UITableViewScrollPositionTop) animated:YES];

                _row=p.section;

            }
        }


}


@end
