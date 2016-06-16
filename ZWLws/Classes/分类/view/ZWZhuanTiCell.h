//
//  ZWZhuanTiCell.h
//  ZWLws
//
//  Created by zhiangkeji on 16/6/3.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWZhuanTiCell : UITableViewCell
@property (nonatomic,strong) NSArray *array;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
