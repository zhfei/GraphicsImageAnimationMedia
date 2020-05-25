//
//  ImageCreater.h
//  ImageHandle
//
//  Created by 周飞 on 2020/4/10.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageCreater : NSObject
//从app程序包内加载图片
- (UIImage *)imageLoadByBundle:(NSString *)name;
//从沙盒document下加载图片
- (UIImage *)imageLoadBySandbox:(NSString *)name;
//从web网络加载图片
- (UIImage *)imageLoadByWebService:(NSURL *)url;


@end

NS_ASSUME_NONNULL_END
