//
//  ZWOtherViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/2.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWOtherViewController.h"
#import "ZWPresentModel.h"
#import "ZWPresentCell.h"
#import "ZWDetailViewController.h"

@interface ZWOtherViewController ()

@end

@implementation ZWOtherViewController

static NSString *ZWid = @"social";

-(NSMutableArray *)PresentArray{
    
    if (_PresentArray== nil) {
        _PresentArray =[NSMutableArray array];
        
    }
    
    return _PresentArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
}
- (void)getData{
    //http://api.liwushuo.com/v2/channels/300/items?gender=1&generation=4&limit=20&offset=0
    //http://api.liwushuo.com/v2/collections/300/posts?gender=1&generation=4&limit=20&offset=0
    [NetworkHelper Get:[NSString stringWithFormat:NextURL,self.ID] parameter:nil success:^(id responseObject) {
        NSLog(@"%@",[NSString stringWithFormat:NextURL,self.ID]);
        //       ZWLog(@"%@",responseObject[@"data"][@"items"]);
        NSArray *array = [ZWPresentModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
        [self.PresentArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];
    
    
    
    
}

#pragma mark - UITablviewDatasource;


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return self.PresentArray.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
        return 180;

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
  
        ZWPresentCell *cell = [ZWPresentCell cellWithTableView:tableView];
        
        cell.Model = self.PresentArray[indexPath.row];
        return cell;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        ZWDetailViewController *detaiVc = [[ZWDetailViewController alloc] init];
        ZWPresentModel *model =self.PresentArray[indexPath.row];
        detaiVc.url = model.url;
        [self.navigationController pushViewController:detaiVc animated:YES];

    
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
