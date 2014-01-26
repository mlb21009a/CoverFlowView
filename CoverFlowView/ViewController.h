//
//  ViewController.h
//  CoverFlowView
//
//  Created by マック太郎 on 2014/01/19.
//  Copyright (c) 2014年 マック太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverFlowView.h"

@interface ViewController : UIViewController<CoverFlowViewDelegate>

@property(weak, nonatomic) IBOutlet CoverFlowView *coverFlow;

@end
