//
//  TranslateView.m
//  Graphics_Quartz
//
//  Created by 周飞 on 2020/4/10.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "TranslateView.h"

@implementation TranslateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//CTM (current transformation matrix)当前 变换 矩阵
//坐标与矩阵变换参数 相乘 ，得到最新的坐标信息。

//UIKit的绘图坐标 和 Quartz 2D的绘图坐标是上下对称的。即：UIKit的坐标原点在左上角，Quartz 2D的坐标原点在左下角
//X轴方向相同，Y轴方向向反
- (void)drawRect:(CGRect)rect {
    // UIKit
    [[UIColor brownColor] setFill];
    UIRectFill(rect);

    UIImage *image = [UIImage imageNamed:@"cat.jpeg"];
    [image drawAtPoint:CGPointMake(200, 0)];
    
    //Quartz 2D
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将Quartz 2D的坐标系转换成UIKit的坐标系
    CGContextSaveGState(context);
     
//    CGContextTranslateCTM(context, 0, image.size.height);
//    CGContextScaleCTM(context, 1, -1);
    
    //将Quartz 2D的坐标系原点沿X轴正方向平移，然后沿Y轴反转（注意：偏移的是原点，无论r如何偏移，上下文一直在第一象限中）
    CGContextTranslateCTM(context, image.size.width, 0);
    CGContextScaleCTM(context, -1, 1);
    
    
    CGRect cgRect = CGRectMake(0, 10, image.size.width, image.size.height);
    CGImageRef cgimage = image.CGImage;
    CGContextDrawImage(context, cgRect, cgimage);
    
    CGContextRestoreGState(context);
}

@end
