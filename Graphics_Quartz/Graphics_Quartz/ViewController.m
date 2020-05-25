//
//  ViewController.m
//  Graphics_Quartz
//
//  Created by 周飞 on 2020/4/9.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Util.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImage *image = [UIImage imageNamed:@"cat"];
    
    image = [UIImage backgroundImageWithImage:image bgRect:CGRectMake(0, 0, 150, 150) bgColor:[UIColor grayColor] corner:10];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];

    imageV.center = CGPointMake(200, 200);
    
    [self.view addSubview:imageV];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


@end
