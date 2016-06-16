//
//  QuickCreateView.h
//  03-自定义标签栏2
//
//  Created by Jarvan on 15/11/11.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickCreateView : UIView

/** 快速创建系统按键*/
+ (UIButton *)addSystemButtonWithFrame:(CGRect)frame
                                 title:(NSString *)title
                                   tag:(int)tag
                                target:(id)target
                                action:(SEL)action;

/** 快速创建图片按键*/
+ (UIButton *)addCustomButtonWithFrame:(CGRect)frame
                                 title:(NSString *)title
                                 image:(UIImage *)image
                               bgImage:(UIImage *)bgImage
                                   tag:(int)tag
                                target:(id)target
                                action:(SEL)action;

/** 快速创标签*/
+ (UILabel *)addLableWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)color;

/** 快速图片视图*/
+ (UIImageView *)addImageViewWithFrame:(CGRect)frame
                                 image:(UIImage *)image;

@end
