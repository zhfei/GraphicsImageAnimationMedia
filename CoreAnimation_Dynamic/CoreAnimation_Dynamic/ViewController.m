//
//  ViewController.m
//  CoreAnimation_Dynamic
//
//  Created by 周飞 on 2020/4/16.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *dynamicView;
@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.dynamicView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self addG];
}

- (void)addG {
    //力学动画
    UIDynamicAnimator *dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    //力学行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    //力学项目
    id <UIDynamicItem> dynamicItem = self.dynamicView;
    
    self.dynamicAnimator = dynamicAnimator;
    [dynamicAnimator addBehavior:gravityBehavior];
    [gravityBehavior addItem:dynamicItem];
    
}

- (UIView *)dynamicView {
    if (!_dynamicView) {
        UIView *dview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
        dview.backgroundColor = [UIColor redColor];
        _dynamicView = dview;
    }
    return _dynamicView;
}


@end
