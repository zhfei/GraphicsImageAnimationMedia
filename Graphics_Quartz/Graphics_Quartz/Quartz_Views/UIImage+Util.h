//
//  UIImage+Util.h
//  Graphics_Quartz
//
//  Created by 周飞 on 2020/5/11.
//  Copyright © 2020 zhf. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Util)
+ (UIImage *)backgroundImageWithImage:(UIImage *)image bgRect:(CGRect)bgRect bgColor:(UIColor *)bgColor corner:(CGFloat)corner;

@end

NS_ASSUME_NONNULL_END
