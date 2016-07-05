//
//  ViewController.m
//  测试屏幕旋转
//
//  Created by len on 15/11/9.
//  Copyright (c) 2015年 wandels. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"first";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ImageViewController *imageviewC = [[ImageViewController alloc] init];
    [self.navigationController pushViewController:imageviewC animated:YES];
//    [self presentViewController:imageviewC animated:YES completion:nil];
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
