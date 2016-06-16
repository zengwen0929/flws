//
//  ZWDuixiangCell.h
//  ZWLws
//
//  Created by 曾文 on 16/6/4.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWDuixiangCell : UITableViewCell
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,assign) CGFloat Height;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
