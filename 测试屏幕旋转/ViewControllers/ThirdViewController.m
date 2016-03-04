//
//  ThirdViewController.m
//  测试屏幕旋转
//
//  Created by Walden on 16/3/4.
//  Copyright © 2016年 wandels. All rights reserved.
//

#import "ThirdViewController.h"
#import "NaviViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

// 判断这个viewController是否支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NaviViewController *naviVC = self.navigationController;
    [naviVC rotateToDirection:UIInterfaceOrientationPortrait];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"third";
    
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
