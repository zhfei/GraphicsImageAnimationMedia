//
//  UIImage+Util.m
//  Graphics_Quartz
//
//  Created by 周飞 on 2020/5/11.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "UIImage+Util.h"



@implementation UIImage (Util)
+ (UIImage *)backgroundImageWithImage:(UIImage *)image bgRect:(CGRect)bgRect bgColor:(UIColor *)bgColor corner:(CGFloat)corner {
    CGRect imgRect = CGRectMake(0, 0, image.size.width, image.size.height);

    
    UIGraphicsBeginImageContextWithOptions(bgRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [bgColor setFill];
    UIRectFill(bgRect);
    
//    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:bgRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
//    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:bgRect cornerRadius:corner];
//    CGContextAddPath(ctx,path.CGPath);
//    CGContextClip(ctx);
    
    CGFloat dx = (bgRect.size.width - imgRect.size.width)/2;
    CGFloat dy = (bgRect.size.height - imgRect.size.height)/2;
    [image drawInRect:CGRectInset(bgRect, dx, dy)];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;

}
@end
