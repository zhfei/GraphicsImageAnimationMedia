//
//  ViewController.m
//  CoreAnimation_UIView
//
//  Created by 周飞 on 2020/4/12.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
    CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
    
    CGPoint center = CGPointMake(widthS/2, 200);
    self.ball.center = center;
    
}

//属性动画
- (IBAction)skipBtnAction:(id)sender {
    CGPoint center = self.ball.center;
    CGFloat tY = center.y > 200 ? 200 : 400;
    self.skipBtn.hidden = !self.skipBtn.hidden;
    
//    [UIView animateWithDuration:1.0 animations:^{
//        self.ball.center = CGPointMake(center.x, tY);
//    } completion:^(BOOL finished) {
//        self.skipBtn.hidden = !self.skipBtn.hidden;
//    }];
    
    [UIView animateWithDuration:1.0 delay:0.3 options:UIViewAnimationOptionAutoreverse animations:^{
        self.ball.center = CGPointMake(center.x, tY);
    } completion:^(BOOL finished) {
        self.skipBtn.hidden = !self.skipBtn.hidden;
    }];
}

//转场动画
- (IBAction)tranformAction:(id)sender {
    [UIView transitionWithView:self.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.view.backgroundColor = [UIColor brownColor];
    } completion:^(BOOL finished) {
        self.view.backgroundColor = [UIColor whiteColor];
    }];
    
}



@end
