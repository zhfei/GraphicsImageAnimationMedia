//
//  CustomNavigationAnimation.h
//  CoreAnimation_CustomTransition
//
//  Created by 周飞 on 2020/4/13.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface CustomNavigationAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) BOOL isPresenting;
@end

NS_ASSUME_NONNULL_END
