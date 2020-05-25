//
//  StrokedFilledTriangle.m
//  Graphics_Quartz
//
//  Created by 周飞 on 2020/4/9.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "StrokedFilledTriangle.h"

@implementation StrokedFilledTriangle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //1.UIKit
    [[UIColor purpleColor] setFill];
    UIRectFill(rect);
    
    //2.Quart 2D
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 100, 20);
    CGContextAddLineToPoint(context, 20, 100);
    CGContextAddLineToPoint(context, 120, 100);
    CGContextClosePath(context);
    
    [[UIColor brownColor] setFill];
    //暂存当前上下文状态
    CGContextSaveGState(context);
    
    [[UIColor redColor] setFill];
    
    //恢复保存的上下文状态
    CGContextRestoreGState(context);
 
    [[UIColor blueColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
