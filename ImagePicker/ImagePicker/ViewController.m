//
//  ViewController.m
//  ImagePicker
//
//  Created by 周飞 on 2020/4/11.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)customNavTransationAction:(id)sender;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

- (IBAction)segmentSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Event
//从摄像头途径获取资源
- (IBAction)pickPhotoCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
        UIImagePickerControllerSourceTypeCamera];
        
        [self presentViewController:_imagePicker animated:YES completion:nil];
    } else {
        NSLog(@"相机不可用");
    }
}

//从相机胶卷途径获取资源
- (IBAction)pickPhotoLibrary:(id)sender {
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    _imagePicker.allowsEditing = YES;
    _imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
    UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    //只访问照片资源
    _imagePicker.mediaTypes = @[@"public.image"];
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

//从相册库途径获取资源
- (IBAction)pickVideoAction:(id)sender {
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    //在相册层级下，可以访问的图片/视频资源
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //返回在相册层级下可以访问的资源类型
    NSArray *mediaArray = [UIImagePickerController availableMediaTypesForSourceType:
    UIImagePickerControllerSourceTypePhotoLibrary];
    //默认的mediaTypes只有kUTTypeImage，所以没有展示视频选项
    _imagePicker.mediaTypes = mediaArray;
    
    //只访问视频资源
    _imagePicker.mediaTypes = @[@"public.movie"];
    
    NSLog(@"mediaArray: %@",mediaArray);
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
}



#pragma mark - Delegate
///MARK: UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    } else if ([mediaType isEqualToString:@"public.movie"]) {
        NSURL *movieURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"视频播放URL:%@",movieURL);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    _imagePicker = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    _imagePicker = nil;

}


///MARK: UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}


#pragma mark - Getter, Setter
- (IBAction)customNavTransationAction:(id)sender {
}

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        
    }
    return _imagePicker;
}

- (IBAction)segmentSelect:(id)sender {
}


@end
