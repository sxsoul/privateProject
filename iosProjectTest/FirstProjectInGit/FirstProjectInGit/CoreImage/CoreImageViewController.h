//
//  CoreImageViewController.h
//  FirstProjectInGit
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreImageViewController : UIViewController

@end
//使用Core Image框架创建滤镜效果一般分为以下几步：

//1.创建图像上下文CIContext
//
//2.创建滤镜CIFilter
//
//3.创建过滤原图片CIImage
//
//4.调用CIFilter的setValue： forKey：方法为滤镜指定源图片
//
//5.设置滤镜参数【可选】
//
//6.取得输出图片显示或保存
