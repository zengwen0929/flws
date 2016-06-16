//
//  ZWDetailViewController.h
//  ZWLws
//
//  Created by zhiangkeji on 16/6/8.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWPresentModel;


@interface ZWDetailViewController : UIViewController

@property (nonatomic,strong) ZWPresentModel *model;

@property (nonatomic,copy) NSString *url;
@end
