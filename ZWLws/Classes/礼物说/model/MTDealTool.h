//
//  MTDealTool.h
//  美团HD
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZWPresentModel;

@interface MTDealTool : NSObject
/**
 *  返回第page页的收藏团购数据:page从1开始
 */
+ (NSArray *)collectDeals:(int)page;
+ (int)collectDealsCount;
/**
 *  收藏一个团购
 */
+ (void)addCollectDeal:(ZWPresentModel *)deal;
/**
 *  取消收藏一个团购
 */
+ (void)removeCollectDeal:(ZWPresentModel *)deal;
/**
 *  团购是否收藏
 */
+ (BOOL)isCollected:(ZWPresentModel *)deal;
@end
