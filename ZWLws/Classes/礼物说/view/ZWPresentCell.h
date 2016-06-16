//
//  ZWPresentCell.h
//  ZWLws
//
//  Created by zhiangkeji on 16/6/3.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWPresentModel;
@interface ZWPresentCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) ZWPresentModel *Model;
@end
