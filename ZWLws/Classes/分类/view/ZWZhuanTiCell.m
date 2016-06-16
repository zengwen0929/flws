//
//  ZWZhuanTiCell.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/3.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWZhuanTiCell.h"
#import "ZWPresentModel.h"
@interface ZWZhuanTiCell ()
@property (nonatomic,strong)UIScrollView *scrollView;

@end
@implementation ZWZhuanTiCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *tsID = @"wen";
    ZWZhuanTiCell *cell = [tableView dequeueReusableCellWithIdentifier:tsID];
    if(cell == nil) {
        cell = [[ZWZhuanTiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tsID];
    }
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 180)];
        scrollView.pagingEnabled = NO;
        
        scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
    }

    return self;
}

-(void)setArray:(NSArray *)array{
    
    self.scrollView.contentSize = CGSizeMake(array.count*Screen_Width/2.3, 180);
    for(int i = 0; i < array.count; i++) {
        
        ZWPresentModel *model = array[i];
        
        CGRect frame = CGRectMake(i*Screen_Width/2.3, 0, Screen_Width/2.3, 80);
       
        
        UIImageView *btnView = [[UIImageView alloc] initWithFrame:frame];
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
        titleL.text = model.title;
        [btnView addSubview:titleL];
        btnView.backgroundColor = [UIColor greenColor];
        btnView.userInteractionEnabled = YES;
        btnView.tag = [model.ID integerValue];
        [btnView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
        [btnView addGestureRecognizer:tap];
        [self.scrollView addSubview:btnView];
    }
    
    
    
}
-(void)Clicktap:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
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
