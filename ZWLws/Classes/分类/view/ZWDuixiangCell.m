//
//  ZWDuixiangCell.m
//  ZWLws
//
//  Created by 曾文 on 16/6/4.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWDuixiangCell.h"
#import "ZWChanels.h"
@interface ZWDuixiangCell ()
@property (nonatomic,strong)UIView *BigView;
@property (nonatomic,strong) UIImageView *btnView;
@property (nonatomic,strong)UILabel *titleL;
@end
@implementation ZWDuixiangCell


+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *tsID = @"wen110";
    ZWDuixiangCell *cell = [tableView dequeueReusableCellWithIdentifier:tsID];
    if(cell == nil) {
        cell = [[ZWDuixiangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tsID];
    }
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UIView *view  = [[UIView alloc] init];
        [self addSubview:view];
        self.BigView = view;
    }
    
    return self;
}

-(void)setArray:(NSArray *)array{
    
    CGFloat Height = (array.count / 4 +1)*80;
    self.BigView.frame = CGRectMake(0, 0, Screen_Height, Height);
    
    NSLog(@"height==%lf",Height);
    NSLog(@"%lf",self.BigView.frame.size.height);

   // NSLog(@"array ==%@",array[0]);

    for(int i = 0; i < array.count; i++) {
        
        ZWChanels *model = array[i];
      //  NSLog(@"%@",model.name);
     
        if (i <4) {
            CGRect frame1 = CGRectMake(10+i*((Screen_Width-50)/4+10), 0, (Screen_Width-50)/4, 70);
            CGRect frame2 = CGRectMake(10+i*((Screen_Width-50)/4+10), 70, (Screen_Width-50)/4, 20);
            self.btnView = [[UIImageView alloc] initWithFrame:frame1];
            self.titleL = [[UILabel alloc] initWithFrame:frame2];
        }
        if (i>=4 && i<8) {
            CGRect frame1 = CGRectMake(10+(i-4)*((Screen_Width-50)/4+10), 90, (Screen_Width-50)/4, 70);
            CGRect frame2 = CGRectMake(10+(i-4)*((Screen_Width-50)/4+10), 160, (Screen_Width-50)/4, 20);
            self.btnView = [[UIImageView alloc] initWithFrame:frame1];
            self.titleL = [[UILabel alloc] initWithFrame:frame2];
        }
        
        if (i>=8 && i<12) {
            CGRect frame1 = CGRectMake(10+(i-8)*((Screen_Width-50)/4+10), 180, (Screen_Width-50)/4, 70);
            CGRect frame2 = CGRectMake(10+(i-8)*((Screen_Width-50)/4+10), 250, (Screen_Width-50)/4, 20);
            self.btnView = [[UIImageView alloc] initWithFrame:frame1];
            self.titleL = [[UILabel alloc] initWithFrame:frame2];
        }
        if (i>=12 && i<16) {
            CGRect frame1 = CGRectMake(10+(i-12)*((Screen_Width-50)/4+10), 270, (Screen_Width-50)/4, 70);
            CGRect frame2 = CGRectMake(10+(i-12)*((Screen_Width-50)/4+10), 340, (Screen_Width-50)/4, 20);
            self.btnView = [[UIImageView alloc] initWithFrame:frame1];
            self.titleL = [[UILabel alloc] initWithFrame:frame2];
        }
        
       
        _titleL.text = model.name;
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.font = [UIFont systemFontOfSize:14];
        [self.BigView  addSubview:_titleL];
       // _btnView.backgroundColor = [UIColor greenColor];
        _btnView.userInteractionEnabled = YES;
        _btnView.tag = [model.ID integerValue];
        [_btnView sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
        [_btnView addGestureRecognizer:tap];
        [self.BigView addSubview:_btnView];
    }
    
  
    
    
}




-(void)Clicktap:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
}


-(void)layoutSubviews{

    [super layoutSubviews];

    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
