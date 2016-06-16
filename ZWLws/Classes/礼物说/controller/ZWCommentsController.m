//
//  ZWCommentsController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/14.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWCommentsController.h"
#import "ZWCommentsModel.h"
#import "ZWUserModel.h"
#import "ZWCommentsTableViewCell.h"
#import "ZWItemsModelFrame.h"

#define HotCommentsUrl @"http://api.liwushuo.com/v2/posts/%@/hot_comments?dataset=top&limit=20&offset=0"
#define CommentsUrl @"http://api.liwushuo.com/v2/posts/%@/comments?limit=20&offset=0"
@interface ZWCommentsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *hotCommentArray;
@property (nonatomic,strong) NSMutableArray *CommentArray;
@end

@implementation ZWCommentsController

- (NSMutableArray *)hotCommentArray{

    if (_hotCommentArray == nil) {
        _hotCommentArray = [NSMutableArray array];
        
    }
    return _hotCommentArray;
}
- (NSMutableArray *)CommentArray{
    
    if (_CommentArray == nil) {
        _CommentArray = [NSMutableArray array];
        
    }
    return _CommentArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    NSLog(@"id == %@",self.ID);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height- 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self getData1];
    [self getData2];
    //
    //
    // Do any additional setup after loading the view.
}

- (void)getData1{
    
    [NetworkHelper Get:[NSString stringWithFormat:HotCommentsUrl,self.ID] parameter:nil success:^(id responseObject) {
        
        NSArray *array= [ZWCommentsModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"comments"]];
          ZWLog(@"%@",responseObject[@"data"][@"comments"]);
        NSMutableArray *arrayM = [NSMutableArray array];
        for (ZWCommentsModel *model in array) {
            ZWItemsModelFrame *f = [[ZWItemsModelFrame alloc] init];
            f.model = model;
            [arrayM addObject:f];
        }
        [self.hotCommentArray addObjectsFromArray:arrayM];
        
 
        [self.tableView reloadData];
 
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];
    
    
}
- (void)getData2{
    
    [NetworkHelper Get:[NSString stringWithFormat:CommentsUrl,self.ID] parameter:nil success:^(id responseObject) {
 
        NSArray *array= [ZWCommentsModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"comments"]];
        ZWLog(@"%@",responseObject[@"data"][@"comments"]);
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (ZWCommentsModel *model in array) {
            ZWItemsModelFrame *f = [[ZWItemsModelFrame alloc] init];
            f.model = model;
            [arrayM addObject:f];
        }
        [self.CommentArray addObjectsFromArray:arrayM];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];
    
    
}
- (void)setNavigationBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"评论";
}

#pragma mark - UITablviewDatasource;


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotCommentArray.count;
    }
    else{
        return self.CommentArray.count;
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
    if (indexPath.section == 0) {
        ZWCommentsTableViewCell *cell = [ZWCommentsTableViewCell cellWithTableView:tableView];
        cell.modelFrame = self.hotCommentArray[indexPath.row];
        return cell;

    }else{
        ZWCommentsTableViewCell *cell = [ZWCommentsTableViewCell cellWithTableView:tableView];
        cell.modelFrame = self.CommentArray[indexPath.row];
        return cell;
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZWItemsModelFrame *frame = self.hotCommentArray[indexPath.row];
        return frame.cellHeight;

    }else{
        ZWItemsModelFrame *frame = self.CommentArray[indexPath.row];
        return frame.cellHeight;

    
    }
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
