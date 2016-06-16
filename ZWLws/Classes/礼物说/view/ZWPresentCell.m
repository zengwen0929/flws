//
//  ZWPresentCell.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/3.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWPresentCell.h"
#import "ZWPresentModel.h"

@interface ZWPresentCell()
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong) UIButton *btn;
@end

@implementation ZWPresentCell
+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *tsID = @"zeng";
    ZWPresentCell *cell = [tableView dequeueReusableCellWithIdentifier:tsID];
    if(cell == nil) {
        cell = [[ZWPresentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tsID];
    }
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UIImageView *imageV= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 180)];
        //imageV.backgroundColor = [UIColor redColor];
        imageV.userInteractionEnabled = YES;
        [self.contentView addSubview:imageV];
        UILabel *titleL  = [[UILabel alloc] initWithFrame:CGRectMake(10, 180-40, Screen_Width, 30)];
        [imageV addSubview:titleL];
        //titleL.backgroundColor = [UIColor greenColor];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width-60, 10, 60, 30)];
        btn.userInteractionEnabled = YES;
        //btn.backgroundColor = [UIColor yellowColor];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [imageV addSubview:btn];
        
        self.btn = btn;
        self.imageV = imageV;
        self.titleL = titleL;
        
    }
    
    
    return self;
}


-(void)setModel:(ZWPresentModel *)Model{

    _Model = Model;
    
    
    //NSLog(@"%@",_Model);

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:_Model.cover_image_url] placeholderImage:nil];
    self.titleL.text = _Model.title;
    self.titleL.textColor = [UIColor whiteColor];
    
    if (_Model.likes_count) {
        [self.btn setTitle:_Model.likes_count forState:UIControlStateNormal];
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
