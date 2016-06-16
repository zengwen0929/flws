//
//  ClassCollectionViewCell.h
//  GiftSay
//
//  Created by lanou on 15/12/19.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWSubcategories,ZWChanels;
@interface ZWClassCollectionViewCell : UICollectionViewCell

@property (nonatomic,retain) UIImageView  *picture;

@property (nonatomic,retain) UILabel  *label;

@property (nonatomic,retain) ZWSubcategories  *model;

@property (nonatomic,retain) ZWChanels  *detail;









@end
