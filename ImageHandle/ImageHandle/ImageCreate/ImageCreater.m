//
//  ImageCreater.m
//  ImageHandle
//
//  Created by 周飞 on 2020/4/10.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ImageCreater.h"

static NSString *KDBPathName = @"DB";

@implementation ImageCreater
- (UIImage *)imageLoadByBundle:(NSString *)name {
    UIImage *cachedImage = [UIImage imageNamed:name];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    UIImage *bundleImg = [UIImage imageWithContentsOfFile:bundlePath];
    
    return bundleImg;
}

- (UIImage *)imageLoadBySandbox:(NSString *)name {
    NSString *imgPath = [self filePathInDocumentsDirectory:name];
    UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
    return img;
}

- (UIImage *)imageLoadByWebService:(NSURL *)url {
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:imgData];
    
    return img;
}

#pragma mark - Tools
- (NSString *)filePathInDocumentsDirectory:(NSString *)name {
    //NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory, NSSearchPathDomainMask domainMask, BOOL expandTilde)
    //此方法的意思是：根据目录名，从指定搜索域下，返回目录的路径。另外指定是否展开波浪线
    //NSSearchPathDirectory：要搜索的目录名；
    //NSSearchPathDomainMask：指定搜索域
    //expandTilde：是否展开波浪线
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    documentsPath = [documentsPath stringByAppendingPathComponent:name];
    return documentsPath;
}

- (void)createEditedCopyOfDatabaseIfNeed {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *dbPath = [self filePathInDocumentsDirectory:KDBPathName];
    
    BOOL dbExit = [fileManager fileExistsAtPath:dbPath];
    if (!dbExit) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:KDBPathName];
        
        //从程序安装包中copy资源到sandbox的数据目录下
        NSError *error;
        BOOL copySuccess = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!copySuccess) {
            NSLog(@"从app程序安装包内copy资源到沙盒Document下失败");
        }
    }
}

@end
