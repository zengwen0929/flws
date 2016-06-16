//
//  ZWOther2ViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/7.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWOther2ViewController.h"
#import "ZWPresentModel.h"

#define NextOtherURL @"http://api.liwushuo.com/v2/collections/%@/posts?gender=1&generation=4&limit=20&offset=0"

@interface ZWOther2ViewController ()

@end

@implementation ZWOther2ViewController


- (void)getData{
    //http://api.liwushuo.com/v2/channels/300/items?gender=1&generation=4&limit=20&offset=0
    //http://api.liwushuo.com/v2/collections/300/posts?gender=1&generation=4&limit=20&offset=0
    [NetworkHelper Get:[NSString stringWithFormat:NextOtherURL,self.ID] parameter:nil success:^(id responseObject) {
        NSLog(@"%@",[NSString stringWithFormat:NextOtherURL,self.ID]);
    ZWLog(@"%@",responseObject[@"data"]);
        
        
        NSArray *array = [ZWPresentModel objectArrayWithKeyValuesArray:responseObject[@"data"][@"posts"]];

        [self.PresentArray addObjectsFromArray:array];
        NSLog(@"self.PresentArray[0]==%@",self.PresentArray[0]);
        [self.tableView reloadData];
        self.title = responseObject[@"data"][@"title"];
    } failure:^(NSError *error) {
        ZWLog(@"%@",error);
    }];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
