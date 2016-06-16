//
//  ZWBtnCell.m
//  ZWLws
//
//  Created by 曾文 on 16/6/6.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWBtnCell.h"
#import "QuickCreateView.h"
@interface ZWBtnCell ()
@property (nonatomic,strong)UIScrollView *scrollView;

@end
@implementation ZWBtnCell


+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *tsID = @"110wen";
    ZWBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:tsID];
    if(cell == nil) {
        cell = [[ZWBtnCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tsID];
    }
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        // 创建按钮
        NSArray *titleArray = @[@"购物车",@"订单",@"礼券",@"客服"];
        NSArray *photoArray = @[@"me_carticon_25x24_@3x.png",@"me_ordericon_25x24_@3x.png",@"me_couponicon_25x24_@3x.png",@"me_serviceicon_25x24_@3x"];
    
        for (int i=0; i<titleArray.count; i++) {
            UIButton *button = [QuickCreateView addCustomButtonWithFrame:CGRectMake(Screen_Width/titleArray.count*i, 10, Screen_Width/titleArray.count, 60) title:titleArray[i] image:[UIImage imageNamed:photoArray[i]] bgImage:nil tag:100+i target:self action:@selector(buttonClick:)];
            
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];

            button.enabled = YES;
            // 偏移
            // 正数一般用于压缩(限制)
            // 负数一般用于偏移
            // UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
            // (0, -30, 0, 0) 距离左边-20   往左边移动20
            // (0, 0, -25, 0) 距离底部-25   往下移动25
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -30, -30, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -28);

            [self addSubview:button];
        }
        
    }

    return self;
}

- (void)buttonClick:(UIButton *)btn{

    NSLog(@"%ld",btn.tag);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
