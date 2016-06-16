//
//  ZWDXFrame.m
//  ZWLws
//
//  Created by 曾文 on 16/6/5.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWDXFrame.h"

@implementation ZWDXFrame
-(void)setArray:(NSArray *)array{

    _array = array;

    _cellHeight = (_array.count / 4 +1)*90;
}
@end
