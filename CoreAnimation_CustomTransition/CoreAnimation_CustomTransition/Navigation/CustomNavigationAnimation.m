//
//  CustomNavigationAnimation.m
//  CoreAnimation_CustomTransition
//
//  Created by 周飞 on 2020/4/13.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "CustomNavigationAnimation.h"

/**
 Standard random float code
 @param min
 @param max
 @result random number between min and max
 */
#define RANDOM_FLOAT(MIN,MAX) (((CGFloat)arc4random() / 0x100000000) * (MAX - MIN) + MIN);


CGFloat AnimationDuration  = 1;

@implementation CustomNavigationAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey
     ];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey
        ];
    
    UIView *containerView = [transitionContext containerView];
    
    //获取fromVC.view的截图
    UIView *mainSnap = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    //生成fromVC.view的截图的水平方向切片, 默认切片高度为4
    NSArray *outgoingLineViews = [self cutView:mainSnap intoSliceOfHeigh:4 yOffset:fromVC.view.frame.origin.y];
    for (UIView *lineView in outgoingLineViews) {
        [containerView addSubview:lineView];
    }
    
    UIView *toView = [toVC view];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    [containerView addSubview:toView];
    
    CGFloat toViewStartX = toView.frame.origin.x;
    toView.alpha = 0;
    fromVC.view.hidden = YES;
    
    BOOL presenting = self.isPresenting;
    
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
    } completion:^(BOOL finished) {
        toVC.view.alpha = 1;
        UIView *mainInSnap = [toView snapshotViewAfterScreenUpdates:YES];
        //转场动画后的视图切片
        NSArray *incomingLineViews = [self cutView:mainInSnap intoSliceOfHeigh:4 yOffset:toView.frame.origin.y];
        
        //没有展示时，将切片向左移动
        [self repositionViewSlices:incomingLineViews moveLeft:!presenting];
        
        for (UIView *v in incomingLineViews) {
            [containerView addSubview:v];
        }
        toView.hidden = YES;
        
        [UIView animateWithDuration:5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self repositionViewSlices:outgoingLineViews moveLeft:presenting];
            [self resetViewSlices:incomingLineViews toXOrigin:toViewStartX];
            
        } completion:^(BOOL finished) {
            fromVC.view.hidden = NO;
            toView.hidden = NO;
            [toView setNeedsUpdateConstraints];
            [incomingLineViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            
            [outgoingLineViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            
            [transitionContext completeTransition:YES];
        }];
    }];
    
    
}



//切片
- (NSMutableArray *)cutView:(UIView *)view intoSliceOfHeigh:(float)height yOffset:(float)yOffset {
    CGFloat lineWidth = CGRectGetWidth(view.frame);
    
    NSMutableArray *lineViews = [NSMutableArray array];
    
    for (int y = 0; y < CGRectGetHeight(view.frame); y += height) {
        CGRect subRect = CGRectMake(0, y, lineWidth, height);
        
        UIView *subSnapshot;
        subSnapshot = [view resizableSnapshotViewFromRect:subRect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        
        subRect.origin.y += yOffset;
        subSnapshot.frame = subRect;
        
        [lineViews addObject:subSnapshot];
    }
    return lineViews;
}

//修改每个切片view的位置
- (void)repositionViewSlices:(NSArray *)views moveLeft:(BOOL)left {
    CGRect frame;
    float width;
    
    for (UIView *line in views) {
        frame = line.frame;
        width = CGRectGetWidth(frame) * RANDOM_FLOAT(1.0, 8.0);
        
        frame.origin.x += left ? -width : width;
        line.frame = frame;
    }
}

//重置切片view的位置到x
- (void)resetViewSlices:(NSArray *)views toXOrigin:(CGFloat)x {
    CGRect frame;
    for (UIView *lineView in views) {
        frame = lineView.frame;
        frame.origin.x = x;
        
        lineView.frame = frame;
    }
}

@end
