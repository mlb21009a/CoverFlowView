//
//  CoverFlowView.h
//  CoverFlowView
//
//  Created by マック太郎 on 2014/01/19.
//  Copyright (c) 2014年 マック太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CoverFlowViewDelegate <NSObject>

@optional
-(void)tapImage:(int)imgNumber;

@end

@interface CoverFlowView : UIScrollView<UIScrollViewDelegate>

@property(weak, nonatomic) id<CoverFlowViewDelegate>coverFolwDelegate;

//画像格納用
@property(nonatomic) NSArray *imgArray;

//画像の初期位置
@property(nonatomic) int initPosition;


@end

