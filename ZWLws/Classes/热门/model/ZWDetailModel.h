//
//  ZWDetailModel.h
//  ZWLws
//
//  Created by zhiangkeji on 16/6/17.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWDetailModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,strong) NSArray *image_urls;
@property (nonatomic,copy) NSString *purchase_url;
@property (nonatomic,copy) NSString *detail_html;

@end
