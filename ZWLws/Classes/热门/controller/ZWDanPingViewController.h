//
//  ZWDanPingViewController.h
//  ZWLws
//
//  Created by zhiangkeji on 16/6/15.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWDetailModel;
@interface ZWDanPingViewController : UIViewController
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,strong) ZWDetailModel *model;
@end
