//
//  ZWChanels.h
//  ZWLws
//
//  Created by 曾文 on 16/6/4.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWChanels : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *icon_url;
@property (nonatomic,strong) NSArray *subcategories;
@end
