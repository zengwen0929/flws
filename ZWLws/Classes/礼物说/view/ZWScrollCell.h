//
//  ZWScrollCell.h
//  ZWLws
//
//  Created by 曾文 on 16/6/2.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWCarouselModel;

@interface ZWScrollCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) ZWCarouselModel *model;
@property (nonatomic,strong) NSArray *array;
@end
