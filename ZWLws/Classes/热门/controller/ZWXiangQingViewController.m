//
//  ZWXiangQingViewController.m
//  ZWLws
//
//  Created by zhiangkeji on 16/6/15.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ZWXiangQingViewController.h"
#import "ZWDetailModel.h"

@interface ZWXiangQingViewController ()

@end

@implementation ZWXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    
    //读取模板内容
    NSString *temp = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    ZWDetailModel *model = self.model;
    
    NSString *json =[NSString stringWithFormat:@"</br></br>%@",model.detail_html] ;
   
    NSString *html = [NSString stringWithFormat:temp, json];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    webView.backgroundColor  = [UIColor redColor];
    [webView loadHTMLString:html baseURL:nil];
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
