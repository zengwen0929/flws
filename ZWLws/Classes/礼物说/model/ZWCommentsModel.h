//
//  ZWCommentsModel.h
//  ZWLws
//
//  Created by zhiangkeji on 16/6/14.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZWUserModel;
@interface ZWCommentsModel : NSObject
@property (nonatomic,strong)  ZWUserModel *user;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *likes_count;
@end
