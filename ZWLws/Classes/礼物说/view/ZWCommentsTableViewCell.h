//
//  ZWCommentsTableViewCell.h
//  ZWLws
//
//  Created by zhiangkeji on 16/6/14.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWItemsModelFrame;

@interface ZWCommentsTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic ,strong)ZWItemsModelFrame *modelFrame;
@end
