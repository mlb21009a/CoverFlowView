//
//  ViewController.m
//  CoverFlowView
//
//  Created by マック太郎 on 2014/01/19.
//  Copyright (c) 2014年 マック太郎. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //UIImageをセット
    _coverFlow.imgArray = @[[
                             UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"], [UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"],[UIImage imageNamed:@"Image"]];
 
    //初期表示位置設定(設定しない場合は0となる)
    _coverFlow.initPosition = 5;
    
    //デリゲートタップイベント用
    _coverFlow.coverFolwDelegate = self;
    
}

//タップした時に呼ばれるデリゲート
-(void)tapImage:(int)imgNumber
{
    NSLog(@"%d", imgNumber);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
