
//
//  CoverFlowView.m
//  CoverFlowView
//
//  Created by マック太郎 on 2014/01/19.
//  Copyright (c) 2014年 マック太郎. All rights reserved.
//

#import "CoverFlowView.h"

@implementation CoverFlowView
{
    //画像格納用
    NSMutableArray *imgViewArray;
    
    //スクロール位置に近い画像の番号
    int championNumber;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        //        self.pagingEnabled = YES;
    }
    return self;
}

//画像の設定
-(void)setImgArray:(NSArray *)imgArray
{
    int cnt = [imgArray count];
    CGFloat width= 0;
    imgViewArray = [NSMutableArray array];
    
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    //奥行き感設定
    perspectiveTransform.m34 = 1.0 / -300;
    self.layer.sublayerTransform = perspectiveTransform;
    
    //画像と位置の設定
    for (int i = 0; i< cnt; i++) {
        if ([imgArray[i] isKindOfClass:[UIImage class]]) {
            UIImageView *imgView = [[UIImageView alloc]initWithImage:imgArray[i]];
            //鏡面画像
            CALayer *layer = [CALayer layer];
            layer.frame = CGRectMake(0, 0, ((UIImage *)imgArray[i]).size.width, ((UIImage *)imgArray[i]).size.height);
            
//            UIImage *mirror = [UIImage imageWithCGImage:((UIImage *)imgArray[i]).CGImage scale:((UIImage *)imgArray[i]).scale orientation:UIImageOrientationDownMirrored];
            
//            UIImageView *vi = [[UIImageView alloc]initWithImage:mirror];
//            [self addSubview:vi];
            
            //鏡面画像設定
            layer.contents = ((id)((UIImage *)imgArray[i]).CGImage);
            layer.opacity = 0.3f;
            layer.transform = CATransform3DMakeRotation(180.0f/180.0f*M_PI, 1.0f, 0.0f, 0);
            
            //viewの識別
            imgView.tag = i+1;
            
            imgView.frame = CGRectMake(0, 0, ((UIImage *)imgArray[i]).size.width, ((UIImage *)imgArray[i]).size.height);
            if (i == 0) {
                width += self.center.x;
            }else {
                width += ((UIImage *)imgArray[i-1]).size.width/2 + ((UIImage *)imgArray[i]).size.width/2;
            }
            
            imgView.center = CGPointMake(width, ((UIImage *)imgArray[i]).size.height/2);
            layer.position = CGPointMake(imgView.layer.frame.size.width/2, imgView.layer.position.y + imgView.layer.frame.size.height + 5.0f);
            
            [self addSubview:imgView];
            [imgView.layer addSublayer:layer];
            [imgViewArray addObject:imgView];
            imgView = nil;
            layer = nil;
        }
    }
    
    //スクロール範囲
    self.contentSize = CGSizeMake(width + self.frame.size.width/2,self.frame.size.height);
    self.initPosition = 0;
    
}



//画像の初期位置設定
-(void)setInitPosition:(int)initPosition
{
    
    //タップイベント検知設定
    ((UIImageView *)imgViewArray[initPosition]).userInteractionEnabled = YES;
    int cnt = [imgViewArray count];
    
    //スクロール位置設定
    for (int i = 0; i< cnt; i++) {
        
        if (((UIImageView *)imgViewArray[i]).tag == initPosition +1) {
            self.contentOffset = CGPointMake(((UIImageView *)imgViewArray[i]).center.x- self.center.x, 0);
            break;
        }
    }
    
    //角度の設定
    for (int i=0; i < cnt; i++) {
        
        if (i < initPosition) {
            [self transformView:(UIImageView *)imgViewArray[i] angle:60.0f];
        }else if(i > initPosition) {
            [self transformView:(UIImageView *)imgViewArray[i] angle:-60.0f];
        }
    }
    
    
}

//ビューの変形
-(void)transformView:(UIImageView *)view angle:(float)rad
{
    view.layer.transform = CATransform3DMakeRotation(rad/180.0f*M_PI, 0.0f, 1.0f, 0.0f);
    view.layer.zPosition = -100;
}

//タップイベント
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if ([((UITouch *)[touches anyObject]).view isKindOfClass:[UIImageView class]]) {
        
        [self.coverFolwDelegate tapImage:((UIImageView *)((UITouch *)[touches anyObject]).view).tag-1];
        
    }
    
}



//スクロール時に呼ばれる
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    float challenger;
    float champion;
    int cnt = [imgViewArray count];
    
    
    //スクロール位置に一番近くにある画像の番号を探す
    for (int i = 0; i< cnt; i++) {
        challenger = fabs(scrollView.contentOffset.x -(((UIImageView *)imgViewArray[i]).center.x- self.center.x));
        if (challenger < champion || i== 0) {
            champion = challenger;
            championNumber = i;
        }
    }
    
    
    
    for (int i = 0; i< cnt; i++) {
        
        if (championNumber < i) {
            
            [UIView animateWithDuration:0.1f animations:^{
                [self transformView:(UIImageView *)imgViewArray[i] angle:-60.0f];
            } completion:^(BOOL finished) {
                
            }];
            
            
        }else if(championNumber > i) {
            [UIView animateWithDuration:0.1f animations:^{
                [self transformView:(UIImageView *)imgViewArray[i] angle:60.0f];
            } completion:^(BOOL finished) {
                
            }];
        }
        
        //タップイベント検知
        ((UIImageView *)imgViewArray[i]).userInteractionEnabled = NO;
        
    }
    
    //タップイベント検知
    ((UIImageView *)imgViewArray[championNumber]).userInteractionEnabled = YES;
    [UIView animateWithDuration:0.1f animations:^{
        ((UIImageView *)imgViewArray[championNumber]).layer.transform = CATransform3DMakeRotation(0, 0.0f, 1.0f, 0.0f);
        ((UIImageView *)imgViewArray[championNumber]).layer.zPosition = 0;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

//スクロール終了時
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.1f animations:^{
        self.contentOffset = CGPointMake(((UIImageView *)imgViewArray[championNumber]).center.x- self.center.x, 0);
    } completion:^(BOOL finished) {
        
    }];
    
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
