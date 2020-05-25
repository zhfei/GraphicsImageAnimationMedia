//
//  ViewController.m
//  CIImage
//
//  Created by 周飞 on 2020/4/11.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)skipBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)tranformAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)faceDetect:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIImage *orignalImage;
@property (assign, nonatomic) NSString *sliderValue;

@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //https://picsum.photos/id/1027/300
    
    NSURL *url = [NSURL URLWithString:@"https://picsum.photos/id/1027/300"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
    self.orignalImage = image;
    
    self.sliderValue = [NSString stringWithFormat:@"%.1f",self.slider.value];
    [self showFilterSubTypes];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self segmentSelect:self.segmentedControl];
        
}



#pragma mark - Private Method
//旧色调
- (void)setImageSepiaToneFilter:(CGFloat)value {
    //Core Image的上下文环境，用于处理CIImage
    //a.创建基于CPU的上下文
    CIContext *cpuContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
    //b.创建基于GPU的上下文,性能好，但不能跨应用访问
    CIContext *gpuContext = [CIContext contextWithOptions:nil];
    //c.创建基于OpenGL优化的上下文，可获得实时性能
    CIContext *glContext = [CIContext contextWithEAGLContext:[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]];
    
    CIImage *ciImage = [CIImage imageWithCGImage:self.orignalImage.CGImage];
    
    //根据滤镜名称生成一个滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
    //使用默认滤镜设置
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:@(value) forKey:kCIInputIntensityKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    
    //对CIImage进行剪裁自定义尺寸
    CGImageRef cgImage = [gpuContext createCGImage:result fromRect:self.imageView.bounds];
    UIImage *resImg = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    self.imageView.image = resImg;
}

//高斯模镜
- (void)setImageGaussianBlurFilter:(NSInteger)value {
    //Core Image的上下文环境，用于处理CIImage
    //a.创建基于CPU的上下文
    CIContext *cpuContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
    //b.创建基于GPU的上下文,性能好，但不能跨应用访问
    CIContext *gpuContext = [CIContext contextWithOptions:nil];
    //c.创建基于OpenGL优化的上下文，可获得实时性能
    CIContext *glContext = [CIContext contextWithEAGLContext:[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]];
    
    CIImage *ciImage = [CIImage imageWithCGImage:self.orignalImage.CGImage];
    
    //根据滤镜名称生成一个滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    //使用默认滤镜设置
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:@(value) forKey:kCIInputRadiusKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    
    //对CIImage进行剪裁自定义尺寸
    CGImageRef cgImage = [gpuContext createCGImage:result fromRect:self.imageView.bounds];
    UIImage *resImg = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    self.imageView.image = resImg;
}

//锐化滤镜
- (void)setImageFilter {
    //Core Image的上下文环境，用于处理CIImage
    //a.创建基于CPU的上下文
    CIContext *cpuContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
    //b.创建基于GPU的上下文,性能好，但不能跨应用访问
    CIContext *gpuContext = [CIContext contextWithOptions:nil];
    //c.创建基于OpenGL优化的上下文，可获得实时性能
    CIContext *glContext = [CIContext contextWithEAGLContext:[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]];
    
    CIImage *ciImage = [CIImage imageWithCGImage:self.orignalImage.CGImage];
    
    //根据滤镜名称生成一个滤镜对象
    CIFilter *sharpFilter = [CIFilter filterWithName:@"CIUnsharpMask"];
    //使用默认滤镜设置
    [sharpFilter setDefaults];
    [sharpFilter setValue:ciImage forKey:kCIInputImageKey];
    CIImage *sharpResult = [sharpFilter valueForKey:kCIOutputImageKey];
    
    //对CIImage进行剪裁自定义尺寸
    CGImageRef cgImage = [gpuContext createCGImage:sharpResult fromRect:self.imageView.bounds];
    UIImage *resImg = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    self.imageView.image = resImg;
}

// MARK: tools
- (void)showFilterSubTypes {
    //1.打印所有的滤镜类型
    NSArray *filterNames = [CIFilter filterNamesInCategory:@"CICategoryBuiltIn"];
    NSLog(@"所有滤镜的个数：%lu --  所有滤镜的名称:%@",(unsigned long)filterNames.count, filterNames);
    
    //2.根据滤镜类型kCICategoryStylize，获取该类型下所有滤镜的名字和属性设置
    NSArray* filters =  [CIFilter filterNamesInCategory:kCICategoryColorEffect];
    for (NSString* filterName in filters) {
      NSLog(@"filter name:%@",filterName);
      // 我们可以通过filterName创建对应的滤镜对象
      CIFilter* filter = [CIFilter filterWithName:filterName];
      NSDictionary* attributes = [filter attributes];
      // 获取属性键/值对（在这个字典中我们可以看到滤镜的属性以及对应的key）
      NSLog(@"filter attributes:%@",attributes);
    }
}

#pragma mark - Public Method

#pragma mark - Event
- (IBAction)sliderAction:(UISlider *)sender {
    if (self.segmentedControl.selectedSegmentIndex == 2) {
        return ;
    }
    
    if (fabs(sender.value - self.sliderValue.floatValue) < 0.1) {
        return;
    }
    
    self.sliderValue = [NSString stringWithFormat:@"%.1f",sender.value];
    [self segmentSelect:self.segmentedControl];
}

- (IBAction)segmentSelect:(UISegmentedControl *)sender {

    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            [self setImageGaussianBlurFilter:self.slider.value*10];
        }
            break;
        case 1:
        {
            [self setImageSepiaToneFilter:self.slider.value];
        }
            break;
        case 2:
        {
            [self setImageFilter];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject

/*
 滤镜效果分类介绍：
 //官方效果：https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorCube
 
 
 //失真效果 改变几何形状创建3D效果
 CORE_IMAGE_EXPORT NSString * const kCICategoryDistortionEffect;
 //扭曲图片和纠正源图像问题，例如仿射变换来校正相对于地平线旋转的图像
 CORE_IMAGE_EXPORT NSString * const kCICategoryGeometryAdjustment;
 //合成滤镜，操作两个图像源
 CORE_IMAGE_EXPORT NSString * const kCICategoryCompositeOperation;
 //半色调效果
 CORE_IMAGE_EXPORT NSString * const kCICategoryHalftoneEffect;
 //色彩调整，用于消除色彩偏移、校正亮度和对比度
 CORE_IMAGE_EXPORT NSString * const kCICategoryColorAdjustment;
 //修改图像颜色，我们一般用的比较多，类似美图工具的滤镜效果
 CORE_IMAGE_EXPORT NSString * const kCICategoryColorEffect;
 //
 CORE_IMAGE_EXPORT NSString * const kCICategoryTransition;
 //瓦片效果 平铺图片
 CORE_IMAGE_EXPORT NSString * const kCICategoryTileEffect;
 //产生图案的过滤器，如纯色、棋盘或星星的光泽。生成的输出通常用作对另一个过滤器的输入。
 CORE_IMAGE_EXPORT NSString * const kCICategoryGenerator;
 //减少图像数据 解决图像分析问题
 CORE_IMAGE_EXPORT NSString * const kCICategoryReduction NS_AVAILABLE(10_5, 5_0);
 //渐变效果
 CORE_IMAGE_EXPORT NSString * const kCICategoryGradient;
 //绘画风格
 CORE_IMAGE_EXPORT NSString * const kCICategoryStylize;
 //锐化图像 锐化掩模和提高亮度。
 CORE_IMAGE_EXPORT NSString * const kCICategorySharpen;
 //柔滑图像，主要用于模糊图像
 CORE_IMAGE_EXPORT NSString * const kCICategoryBlur;
 //处理视频图像
 CORE_IMAGE_EXPORT NSString * const kCICategoryVideo;
 //处理静态图像
 CORE_IMAGE_EXPORT NSString * const kCICategoryStillImage;
 //处理交错图像
 CORE_IMAGE_EXPORT NSString * const kCICategoryInterlaced;
 //处理非方形图像
 CORE_IMAGE_EXPORT NSString * const kCICategoryNonSquarePixels;
 //处理高动态图像
 CORE_IMAGE_EXPORT NSString * const kCICategoryHighDynamicRange;
 //用于区分built-in filters  plug-in filters.
 CORE_IMAGE_EXPORT NSString * const kCICategoryBuiltIn;
 //链接几个过滤器
 CORE_IMAGE_EXPORT NSString * const kCICategoryFilterGenerator NS_AVAILABLE(10_5, 9_0);
 
 */



- (IBAction)faceDetect:(id)sender {
}
@end
