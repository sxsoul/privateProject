//
//  CoreImageViewController.m
//  FirstProjectInGit
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CoreImageViewController.h"

@interface CoreImageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UIImagePickerController *_imagePickerController;//系统照片选择控制器
    UIImageView *_imageView;//图片显示控件
    CIContext *_context;//Core Image上下文
    CIImage *_image;//我们要编辑的图像
    CIImage *_outputImage;//处理后的图像
    CIFilter *_colorControlsFilter;//色彩滤镜
}
@end

@implementation CoreImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initLayout];
}

-(void) initLayout {
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    //创建图片显示控件
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 502)];
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    //上方导航按钮
    self.navigationItem.title=@"图片处理";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"打开相册" style:UIBarButtonItemStyleDone target:self action:@selector(openPhoto:)];
    
    //下方控制面板
    UIView *controlView=[[UIView alloc]initWithFrame:CGRectMake(0, 450, 320, 118)];
    //    controlView.alpha=0.2;
    //    controlView.backgroundColor=[UIColor colorWithRed:46.0/255.0 green:178.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:controlView];
    //饱和度(默认为1，大于饱和度增加小于1则降低)
    UILabel *lbSaturation=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 25)];
    lbSaturation.text=@"饱和度";
    lbSaturation.font=[UIFont systemFontOfSize:12];
    [controlView addSubview:lbSaturation];
    UISlider *sldStaturation=[[UISlider alloc]initWithFrame:CGRectMake(80, 10, 230, 30)];//注意UISlider高度虽然无法调整，很多朋友会说高度设置位0即可，事实上在iOS7中设置为0后是无法拖动的
    [controlView addSubview:sldStaturation];
    sldStaturation.minimumValue=0;
    sldStaturation.maximumValue=2;
    sldStaturation.value=1;
    [sldStaturation addTarget:self action:@selector(changeStaturation:) forControlEvents:UIControlEventValueChanged];
    //亮度(默认为0)
    UILabel *lbBrightness=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 60, 25)];
    lbBrightness.text=@"亮度";
    lbBrightness.font=[UIFont systemFontOfSize:12];
    [controlView addSubview:lbBrightness];
    UISlider *sldBrightness=[[UISlider alloc]initWithFrame:CGRectMake(80, 40, 230, 30)];
    [controlView addSubview:sldBrightness];
    sldBrightness.minimumValue=-1;
    sldBrightness.maximumValue=1;
    sldBrightness.value=0;
    [sldBrightness addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventValueChanged];
    //对比度(默认为1)
    UILabel *lbContrast=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 60, 25)];
    lbContrast.text=@"对比度";
    lbContrast.font=[UIFont systemFontOfSize:12];
    [controlView addSubview:lbContrast];
    UISlider *sldContrast=[[UISlider alloc]initWithFrame:CGRectMake(80, 70, 230, 30)];
    [controlView addSubview:sldContrast];
    sldContrast.minimumValue=0;
    sldContrast.maximumValue=2;
    sldContrast.value=1;
    [sldContrast addTarget:self action:@selector(changeContrast:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, controlView.frame.size.height-30, 80, 30)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(savePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:btn];
    
    //初始化CIContext
    //创建基于CPU的图像上下文
    //    NSNumber *number=[NSNumber numberWithBool:YES];
    //    NSDictionary *option=[NSDictionary dictionaryWithObject:number forKey:kCIContextUseSoftwareRenderer];
    //    _context=[CIContext contextWithOptions:option];
    _context=[CIContext contextWithOptions:nil];//使用GPU渲染，推荐,但注意GPU的CIContext无法跨应用访问，例如直接在UIImagePickerController的完成方法中调用上下文处理就会自动降级为CPU渲染，所以推荐现在完成方法中保存图像，然后在主程序中调用
    
    //取得滤镜
    _colorControlsFilter=[CIFilter filterWithName:@"CIColorControls"];
}

#pragma mark 打开图片选择器
-(void)openPhoto:(UIBarButtonItem *)btn{
    //打开图片选择器
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma mark 保存图片
-(void)savePhoto:(UIBarButtonItem *)btn{
    //保存照片到相册
    UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, nil, nil);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sytem Info" message:@"Save Success!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 图片选择器选择图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //关闭图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
    //取得选择图片
    UIImage *selectedImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image=selectedImage;
    //初始化CIImage源图像
    _image=[CIImage imageWithCGImage:selectedImage.CGImage];
    [_colorControlsFilter setValue:_image forKey:@"inputImage"];//设置滤镜的输入图片
}

#pragma mark 将输出图片设置到UIImageView
-(void)setImage{
    CIImage *outputImage= [_colorControlsFilter outputImage];//取得输出图像
    CGImageRef temp=[_context createCGImage:outputImage fromRect:[outputImage extent]];
    _imageView.image=[UIImage imageWithCGImage:temp];//转化为CGImage显示在界面中
    
    CGImageRelease(temp);//释放CGImage对象
}

#pragma mark 调整饱和度
-(void)changeStaturation:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputSaturation"];//设置滤镜参数
    [self setImage];
}

#pragma mark 调整亮度
-(void)changeBrightness:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputBrightness"];
    [self setImage];
}

#pragma mark 调整对比度
-(void)changeContrast:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputContrast"];
    [self setImage];
}

#pragma mark 查看所有内置滤镜
-(void)showAllFilters{
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for (NSString *filterName in filterNames) {
        CIFilter *filter=[CIFilter filterWithName:filterName];
        NSLog(@"\rfilter:%@\rattributes:%@",filterName,[filter attributes]);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
