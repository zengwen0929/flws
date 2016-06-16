//
//  ZWScrollCell.m
//  ZWLws
//
//  Created by 曾文 on 16/6/2.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWScrollCell.h"
#import "ZWCarouselModel.h"
#import "ZWOther2ViewController.h"
@interface ZWScrollCell ()
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *urlArray;
@end
@implementation ZWScrollCell
-(NSMutableArray *)urlArray{

    if (_urlArray ==nil) {
        _urlArray = [NSMutableArray array];
    }

    return _urlArray;
}


+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *tsID = @"zengwen";
    ZWScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:tsID];
    if(cell == nil) {
        cell = [[ZWScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tsID];
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
    
     NSMutableArray *arrym = [NSMutableArray array];
    self.scrollView.contentSize = CGSizeMake(array.count*Screen_Width/4, 180);
    for(int i = 0; i < array.count; i++) {
        
        ZWCarouselModel *model = array[i];
        
        CGRect frame = CGRectMake(i*Screen_Width/4, 0, Screen_Width/4, 80);
        
        UIImageView *btnView = [[UIImageView alloc] initWithFrame:frame];
        btnView.backgroundColor = [UIColor greenColor];
        btnView.userInteractionEnabled = YES;
        btnView.tag = i ;
       
        [arrym addObject:model.target_url];
  
        [btnView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
        [btnView addGestureRecognizer:tap];
        [self.scrollView addSubview:btnView];
    }
    
    [self.urlArray addObjectsFromArray:arrym];
    
    
}



-(void)Clicktap:(UITapGestureRecognizer *)sender{
   
    NSLog(@"%@",self.urlArray[sender.view.tag]);
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ButtonDidClickNotification" object:nil userInfo:@{@"ButtonClickTag": self.urlArray[sender.view.tag]}];
    

}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

