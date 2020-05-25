//
//  ViewController.m
//  CoreAnimation_CustomTransition
//
//  Created by 周飞 on 2020/4/13.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"
#import "CustomNavigationAnimation.h"

@interface ViewController () <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
}


- (IBAction)customNavTransationAction:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *sbVC = [sb instantiateViewControllerWithIdentifier:@"CustomNav"];
//    
//    sbVC.transitioningDelegate = self;
//    [self.navigationController pushViewController:sbVC animated:YES];
}

- (IBAction)customNavModalAction:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *sbVC = [sb instantiateViewControllerWithIdentifier:@"CustomModal"];
//    
//    sbVC.transitioningDelegate = self;
//    [self presentViewController:sbVC animated:YES completion:nil];
}

//在子孙控制器中，选择一个按钮可以直接连接到rootVC的Exit处，直接返回到rootVC的此函数
- (IBAction)customModalExitAction:(UIStoryboardSegue *)sender {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *desVC = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"CustomNav"]) {
        
    } else if ([segue.identifier isEqualToString:@"CustomModal"]) {
        desVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    
    
    desVC.transitioningDelegate = self;
}


#pragma mark - delegate
///UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                       animationControllerForOperation:(UINavigationControllerOperation)operation
                                                  fromViewController:(UIViewController *)fromVC
                                                    toViewController:(UIViewController *)toVC {
    CustomNavigationAnimation *customAni = [CustomNavigationAnimation new];
    if (operation == UINavigationControllerOperationPop) {
        customAni.isPresenting = NO;
    } else {
        customAni.isPresenting = YES;
    }
    
    return customAni;
}



///UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    CustomNavigationAnimation *customAni = [CustomNavigationAnimation new];
    customAni.isPresenting = NO;
    
    return customAni;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    CustomNavigationAnimation *customAni = [CustomNavigationAnimation new];
    customAni.isPresenting = YES;
    
    return customAni;
}

@end
