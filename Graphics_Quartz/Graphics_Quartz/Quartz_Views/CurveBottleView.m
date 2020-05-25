//
//  CurveBottleView.m
//  Graphics_Quartz
//
//  Created by 周飞 on 2020/4/10.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "CurveBottleView.h"

@implementation CurveBottleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    //设置上下文背景
    [[UIColor purpleColor] setFill];
    UIRectFill(rect);
    
    //Quarts 2D绘图
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat startX = 100;
    CGFloat startY = 20;
    
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddArcToPoint(context, startX + 50, startY + 10, startX - 50, startY + 50, 50);
    CGContextAddArcToPoint(context, startX + 100, startY + 100, startX + 200, startY + 50 , 100);
    CGContextClosePath(context);
    
    [[UIColor brownColor] setFill];
    [[UIColor redColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
