//
//  FillView.m
//  GraphicsImageAnimationMedia
//
//  Created by 周飞 on 2020/4/9.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "FillView.h"

@implementation FillView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//UIKit接口 绘图
- (void)drawRect:(CGRect)rect {
    //设置当前上下文的填充色
    [[UIColor brownColor] setFill];
    UIRectFill(rect);
    
    [[UIColor whiteColor] setStroke];
    UIRectFrame(CGRectInset(rect, 20, 20));
    
    UIBezierPath *bez = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 20, 20)];
    [bez stroke];
}

@end
