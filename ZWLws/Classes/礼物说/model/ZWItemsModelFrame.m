//
//  ItemsModelFrame.m
//  曾文
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import "ZWItemsModelFrame.h"
#import "ZWCommentsModel.h"
#import "ZWUserModel.h"
#define ZWCellBoraderWH 10

@implementation ZWItemsModelFrame
-(void)setModel:(ZWCommentsModel *)model{
    _model =model;

    ZWUserModel *user = model.user;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat iconViewX = ZWCellBoraderWH;
    CGFloat iconViewY = ZWCellBoraderWH;
    CGFloat iconViewWH = 50;
    
    self.iconViewF =CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    CGSize nameSize = [self sizeWithText:user.nickname font:[UIFont systemFontOfSize:17]];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    
    self.nameLabelF = CGRectMake(CGRectGetMaxX(self.iconViewF) +ZWCellBoraderWH,(CGRectGetMaxY(self.iconViewF)-ZWCellBoraderWH)/2, nameW, nameH);
    
    CGSize conttentSize = [self sizeWithText:model.content font:[UIFont systemFontOfSize:17] maxW:screenW-ZWCellBoraderWH];
    CGFloat contentW = conttentSize.width;
    CGFloat contentH = conttentSize.height;
    
    self.contentLabelF = CGRectMake(ZWCellBoraderWH, CGRectGetMaxY(self.iconViewF)+ZWCellBoraderWH, contentW, contentH);
    
 
    self.cellHeight = CGRectGetMaxY(self.contentLabelF)+ZWCellBoraderWH;


}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}


@end
