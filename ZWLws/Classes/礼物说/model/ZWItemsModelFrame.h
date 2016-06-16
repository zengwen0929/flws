//
//  ItemsModelFrame.h
//  曾文
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 zengwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZWCommentsModel,ZWUserModel;
@interface ZWItemsModelFrame : NSObject

@property (nonatomic, strong) ZWCommentsModel *model;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
