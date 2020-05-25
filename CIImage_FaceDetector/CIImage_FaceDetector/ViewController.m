//
//  ViewController.m
//  CIImage_FaceDetector
//
//  Created by 周飞 on 2020/4/12.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *inputImageView;
@property (weak, nonatomic) IBOutlet UIImageView *outputImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)faceDetect:(id)sender {
    //对CGImage, CIImage处理后得到的结果，在绘制到UIView上时，需要对这个UIView进行Y轴对称
    //因为CGImage, CIImage的坐标系原点在左下角， 而UIKit的坐标系原点在左上角
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [CIImage imageWithCGImage:self.inputImageView.image.CGImage];
    //face检查滤镜
    CIDetector *detetor = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    
    //获得面部识别结果
    NSArray<CIFeature *> *resultArray = [detetor featuresInImage:ciImage];
    
    UIView *resultView = [[UIView alloc] initWithFrame:self.inputImageView.frame];
    [self.view addSubview:resultView];
    
    for (CIFaceFeature *faceFeature in resultArray) {
        //标记脸部位置
        UIView *faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        faceView.layer.borderColor = [UIColor orangeColor].CGColor;
        faceView.layer.borderWidth = 1;
        [resultView addSubview:faceView];
        //标记左眼睛位置
        if (faceFeature.hasLeftEyePosition) {
            UIView *leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            leftEyeView.layer.borderColor = [UIColor orangeColor].CGColor;
            leftEyeView.layer.borderWidth = 1;
            leftEyeView.center = faceFeature.leftEyePosition;
            [resultView addSubview:leftEyeView];
        }
        //标记右眼睛位置
        if (faceFeature.hasRightEyePosition) {
            UIView *rightEyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            rightEyeView.layer.borderColor = [UIColor orangeColor].CGColor;
            rightEyeView.layer.borderWidth = 1;
            rightEyeView.center = faceFeature.rightEyePosition;
            [resultView addSubview:rightEyeView];
        }
        //标记嘴巴位置
        if (faceFeature.hasMouthPosition) {
            UIView *mouthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
            mouthView.layer.borderColor = [UIColor orangeColor].CGColor;
            mouthView.layer.borderWidth = 1;
            mouthView.center = faceFeature.mouthPosition;
            [resultView addSubview:mouthView];
        }
        
    }
    [resultView setTransform:CGAffineTransformMakeScale(1, -1)];
    
    
    //截取面部图片，展示到结果区
    if (resultArray.count > 0) {
        //从原始ciImage中截切出脸部faceImage
        CIImage *faceImage = [ciImage imageByCroppingToRect:[resultArray firstObject].bounds];
        
        //通过CIContext，将CIImage转化成CGImage
        CGImageRef faceImageRes = [context createCGImage:faceImage fromRect:faceImage.extent];
        UIImage *face = [UIImage imageWithCGImage:faceImageRes];
        
        self.outputImageView.image = face;
    }
}


- (IBAction)skipBtnAction:(id)sender {
}
- (IBAction)tranformAction:(id)sender {
}
@end
