//
//  ZWCommentsTableViewCell.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/14.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWCommentsTableViewCell.h"
#import "ZWItemsModelFrame.h"
#import "ZWCommentsModel.h"
#import "ZWUserModel.h"
@interface ZWCommentsTableViewCell ()
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong) UILabel *nicknameL;
@property (nonatomic,strong) UIButton *btn;
@end

@implementation ZWCommentsTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"comments";
    ZWCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[ZWCommentsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UIImageView *imageV= [[UIImageView alloc]init];
        //imageV.backgroundColor = [UIColor redColor];
        CALayer *lay  = imageV.layer;//获取ImageView的层
        [lay setMasksToBounds:YES];
        [lay setCornerRadius:25];
      //  imageV.userInteractionEnabled = YES;
        [self.contentView addSubview:imageV];
        UILabel *titleL  = [[UILabel alloc] init];
        titleL.numberOfLines = 0;
        [self.contentView addSubview:titleL];
        UILabel *nicknameL  = [[UILabel alloc] init];
        [self.contentView addSubview:nicknameL];
        //titleL.backgroundColor = [UIColor greenColor];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 30, 10, 30, 30)];
        btn.userInteractionEnabled = YES;
        //btn.backgroundColor = [UIColor yellowColor];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        self.btn = btn;
        self.imageV = imageV;
        self.titleL = titleL;
        self.nicknameL = nicknameL;
        
    }
    
    
    return self;
}
-(void)setModelFrame:(ZWItemsModelFrame *)modelFrame{
    _modelFrame = modelFrame;
    ZWCommentsModel *model = modelFrame.model;
    ZWUserModel *m = model.user;
    
    //NSLog(@"%@",_Model);
    self.nicknameL.frame = modelFrame.nameLabelF;
    self.nicknameL.text = m.nickname;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:m.avatar_url] placeholderImage:[UIImage imageNamed:@"me_avatarplaceholder_75x75_@2x"]];
    self.imageV.frame = modelFrame.iconViewF;
    self.titleL.text = model.content;
    self.titleL.frame = modelFrame.contentLabelF;
    if (model.likes_count) {
        [self.btn setTitle:model.likes_count forState:UIControlStateNormal];
    }
    
    
}

-(void)click{
    
    NSLog(@"click");
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
