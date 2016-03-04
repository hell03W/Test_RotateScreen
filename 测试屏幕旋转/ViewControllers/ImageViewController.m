//
//  ImageViewController.m
//  测试屏幕旋转
//
//  Created by len on 15/11/9.
//  Copyright (c) 2015年 wandels. All rights reserved.
//

#import "ImageViewController.h"
#import "NaviViewController.h"
#import "ThirdViewController.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ImageViewController ()
{
    NSInteger realScreenWidth;
    NSInteger realScreenHeight;
    NSInteger imageIndex;
    
    CGSize ScreenSize;
}


@property (nonatomic, strong)UIScrollView *scroll;

@end

@implementation ImageViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ThirdViewController *third = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:third animated:YES];
}

// 判断这个viewController是否支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

//// 设置手机屏幕支持旋转的方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait |
//    UIInterfaceOrientationMaskLandscapeLeft |UIInterfaceOrientationMaskLandscapeRight;
//    
//}

//- (BOOL)shouldAutorotate
//{
//    return YES;
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

// 手机支持屏幕旋转，并且屏幕已经旋转的时候，会调用这个方法，在这个方法里面，可以重新给view布局以适应不同的屏幕方向
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"横屏模式");
    NSLog(@"%lf, %lf", ScreenWidth, ScreenHeight);
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        NSLog(@"UIInterfaceOrientationLandscapeLeft");
        realScreenWidth = ScreenSize.height;
        realScreenHeight = ScreenSize.width;
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"UIInterfaceOrientationLandscapeRight");
        realScreenWidth = ScreenSize.height;
        realScreenHeight = ScreenSize.width;
    }
    else if (toInterfaceOrientation == UIDeviceOrientationPortrait)
    {
        NSLog(@"UIDeviceOrientationPortrait");
        realScreenWidth = ScreenSize.width;
        realScreenHeight = ScreenSize.height;
    }
    
    [self reloadScroll];
}

// 控制器将要出现时候, 强制屏幕转换, 如果不需要屏幕转换, 不要调用navi中的 rotateToDirection: 方法即可.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NaviViewController *naviVC = self.navigationController;
    [naviVC rotateToDirection:UIInterfaceOrientationLandscapeRight];
    [self willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight duration:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToNextVC)];
    self.title = @"second";
    ScreenSize = CGSizeMake(ScreenWidth, ScreenHeight);
    
    realScreenWidth = ScreenWidth;
    realScreenHeight = ScreenHeight;
    
    [self loadScroll];
}

- (void)jumpToNextVC
{
    ThirdViewController *third = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:third animated:YES];
}

// 重新摆放放在屏幕上的元素的大小和位置
- (void)reloadScroll
{
    NSLog(@"重置 winth = %ld, height = %ld", realScreenWidth, realScreenHeight);
    
    _scroll.frame = CGRectMake(0, 0, realScreenWidth, realScreenHeight);
    _scroll.contentSize = CGSizeMake(3 * realScreenWidth, realScreenHeight);
    
    CGPoint contentoffset = CGPointMake(realScreenWidth * imageIndex, 0);
    _scroll.contentOffset = contentoffset;
    
    int i = 0;
    for (UIView *imageView in [_scroll subviews])
    {
        if ([imageView isKindOfClass:[UIImageView class]])
        {
            imageView.frame = CGRectMake(i * realScreenWidth, 0, realScreenWidth, realScreenHeight);
        }
        ++i;
    }
}

// 第一次按照竖屏创建并展示三个放在scrollView上的图片
- (void)loadScroll
{
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, realScreenWidth, realScreenHeight)];
    [self.view addSubview:_scroll];
    _scroll.pagingEnabled = YES;
    _scroll.bounces = YES;
    _scroll.backgroundColor = [UIColor purpleColor];
    
    for (int i = 1; i <= 3; i++) {
        UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake((i - 1) * realScreenWidth, 0, realScreenWidth, realScreenHeight)];
        [_scroll addSubview:imagView];
        imagView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
        imagView.contentMode = UIViewContentModeScaleAspectFit;
    }
    _scroll.contentSize = CGSizeMake(realScreenWidth * 3, realScreenHeight - 64);
}



@end
