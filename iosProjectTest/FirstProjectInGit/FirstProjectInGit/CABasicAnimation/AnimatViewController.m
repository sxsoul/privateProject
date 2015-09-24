//
//  AnimatViewController.m
//  FirstProjectInGit
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AnimatViewController.h"

@interface AnimatViewController ()

@end

@implementation AnimatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基础动画";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    [self initScaleLayer];
    [self initGroupAnimat];
}

- (void)initScaleLayer {
    //初始化
    CALayer *scaleLayer = [[CALayer alloc] init];
    scaleLayer.backgroundColor = [UIColor blueColor].CGColor;
    scaleLayer.frame = CGRectMake(60, 100, 50, 50);
    scaleLayer.cornerRadius = 10;
    [self.view.layer addSublayer:scaleLayer];
    
    //设定剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.2];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.5;
    
    //开演
    [scaleLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)initGroupAnimat {
    //初始化
    CALayer *groupLayer = [[CALayer alloc] init];
    groupLayer.backgroundColor = [UIColor redColor].CGColor;
    groupLayer.frame = CGRectMake(60, 200, 50, 50);
    groupLayer.cornerRadius = 10.f;
    [self.view.layer addSublayer:groupLayer];
    //设定剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.z"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.2];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 1.5;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 1.5f;
    
    CABasicAnimation *transformAnimat = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    transformAnimat.fromValue = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
    transformAnimat.toValue = [NSValue valueWithCGSize:CGSizeMake(20, 50)];
    transformAnimat.autoreverses = YES;
    transformAnimat.repeatCount = MAXFLOAT;
    transformAnimat.duration = 1.5f;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 2.f;
    groupAnimation.animations = @[rotateAnimation, transformAnimat, scaleAnimation];
    groupAnimation.autoreverses = YES;
    groupAnimation.repeatCount = MAXFLOAT;
    //开始演播
    [groupLayer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
