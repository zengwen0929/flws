//
//  ZWChanels.m
//  ZWLws
//
//  Created by 曾文 on 16/6/4.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWChanels.h"
#import "ZWSubcategories.h"

@implementation ZWChanels
-(NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
    
}
- (NSDictionary *)objectClassInArray
{
    return @{@"subcategories" : [ZWSubcategories class]};
}

@end
