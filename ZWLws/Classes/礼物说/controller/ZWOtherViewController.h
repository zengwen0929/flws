//
//  ZWOtherViewController.h
//  ZWLws
//
//  Created by zhiangkeji on 16/6/2.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWOtherViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *PresentArray;

@property (nonatomic,copy) NSString *ID;

- (void)getData;
@end
