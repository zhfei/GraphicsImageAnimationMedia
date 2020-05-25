//
//  AffineTransformView.m
//  Graphics_Quartz
//
//  Created by 周飞 on 2020/4/10.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "AffineTransformView.h"

@implementation AffineTransformView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//仿射：连续矩阵变换叠加，也是一种2D坐标变换，连续的2D坐标相乘
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //UIKit 绘图
    [[UIColor brownColor] setFill];
    UIRectFill(rect);
    
    //Quartz 2D绘图
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIImage *image = [UIImage imageNamed:@"cat.jpeg"];
    [image drawAtPoint:CGPointMake(200, 0)];
    
    CGContextSaveGState(context);
//    CGAffineTransform affine = CGAffineTransformMakeScale(1, -1);
//    affine = CGAffineTransformTranslate(affine, 0, image.size.height);
    
    //仿射的先后顺序有很大的关系，因为后面的函数要用前面函数的值作为参数。
    CGAffineTransform affine = CGAffineTransformMakeTranslation(0, image.size.height);
    affine = CGAffineTransformScale(affine, 1, -1);
    affine = CGAffineTransformScale(affine, 0.5, 0.5);
    //将设置信息更新到Quartz 2D坐标系
    CGContextConcatCTM(context, affine);
    
    CGImageRef cgImg = image.CGImage;
    CGRect cgRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(context, cgRect, cgImg);
    
    CGContextRestoreGState(context);
    
}

@end
