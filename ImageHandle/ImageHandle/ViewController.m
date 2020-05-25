//
//  ViewController.m
//  ImageHandle
//
//  Created by 周飞 on 2020/4/10.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"
#import "ImageCreater.h"

@interface ViewController ()
- (IBAction)pickPhotoCamera:(id)sender;
- (IBAction)pickPhotoLibrary:(id)sender;
- (IBAction)pickPhotoLibrary:(id)sender;
- (IBAction)pickVideoAction:(id)sender;
- (IBAction)pickPhotoLibrary:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ImageCreater *imgCreater = [ImageCreater new];
    
    NSURL *url = [NSURL URLWithString:@"https://picsum.photos/300/200"];
    UIImage *img = [imgCreater imageLoadByWebService:url];
    self.imageView.image = img;
}


- (IBAction)pickPhotoCamera:(id)sender {
}

- (IBAction)pickPhotoLibrary:(id)sender {
}

- (IBAction)pickVideoAction:(id)sender {
}

- (IBAction)pickPhotoLibrary:(id)sender {
}

- (IBAction)pickPhotoLibrary:(UIButton *)sender {
}
@end
