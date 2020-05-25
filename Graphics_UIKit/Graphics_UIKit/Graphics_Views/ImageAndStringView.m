//
//  ImageAndStringView.m
//  GraphicsImageAnimationMedia
//
//  Created by 周飞 on 2020/4/9.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ImageAndStringView.h"

@implementation ImageAndStringView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//可以理解为UILabel也是在此方法中添加了文字描绘
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[UIColor brownColor] setFill];
    UIRectFill(rect);
    
    
    UIImage *image = [UIImage imageNamed:@"dog_169"];
//    [image drawInRect:CGRectMake(0, 50, 300, 100)];
    [image drawAsPatternInRect:CGRectMake(0, 50, 300, 100)];
    
    NSFont *font = [UIFont systemFontOfSize:30];
    NSDictionary *attDict = @{NSFontAttributeName:font};
    NSString *text = @"My Dog";
    [text drawAtPoint:CGPointZero withAttributes:attDict];
    
}

@end
