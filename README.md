# Test_RotateScreen
关于iOS上面的屏幕旋转, 以前写过简单的demo, 最近帮朋友解决了屏幕旋转出现的一些问题, 顺便写个demo分享出来. 

iOS上面的屏幕旋转不很难, 最重要的是理解其中的原理. 一般情况下, 一个应用并不是所有的页面都支持屏幕旋转, 一般只有个别的页面是支持屏幕旋转的, 这时候, 需要在plist中选择应用所支持的屏幕方向, 在应用的根控制器中返回默认的(一般是竖屏)方向, 在需要支持不同方向的控制器中返回所支持的旋转方向. 
### 1. 应用支持的屏幕旋转方向
首先应该配置应用所支持的屏幕旋转方向, 这里应该配置, 此应用支持的所有的屏幕旋转方向, 可以在`plist`中配置, 如下图所示:
![](http://ww1.sinaimg.cn/large/6281e9fbgw1f1ly40jcbbj20vu04eta3.jpg)
也可以在`General`中配置:
![](http://ww4.sinaimg.cn/large/6281e9fbgw1f1ly8cwpa7j21jw0j6aig.jpg)

### 1. UINavigationController和屏幕旋转
一般情况下, 应用的根视图都是UINavigationController, 这时候需要在UINavigationController中返回当前正在展示的控制器(ViewController)所支持的屏幕旋转方向, 示例代码如下所示:

```
//返回当前正在显示的控制器是否支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

// 返回当前正在显示的控制器支持的屏幕旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

// 返回当前正在显示的控制器，最佳的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

```

在需要支持不同方向屏幕旋转时候, 需要在控制器中写下如下代码:

```
// 返回这个viewController是否支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

// 返回此ViewController支持的屏幕方向.
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
```

### 2. 屏幕旋转时候遇到的其它问题
1. 一般情况下, 使用以上代码即可实现屏幕旋转的相关操作, 但是也会出现一些问题, 就是, 如果我们的应用个别页面需要支持左右屏幕, 其它页面只需要竖屏模式, 这时候, 我们需要在我们所有页面的根控制器中返回支持的屏幕方向是竖屏模式, 然后在需要支持左右旋转的页面再返回需要支持的屏幕旋转反向即可. 
2. 如果一个页面需要支持不同的屏幕方向, 那么需要在 `willRotateToInterfaceOrientation:duration:`方法中判断当前正在展示的屏幕反向是横屏还是竖屏, 然后重新布局整个view上面的元素(详见dmeo).
3. 例如, 从一个只支持横屏模式的控制器中push到一个只支持竖屏模式的控制器中, 这时候, 如果按照常规的模式, push进来的页面和上一个页面的屏幕方向是相同的, 不会自动的发生改变, 如果想要自动的发生改变, 需要在新控制器的viewWillAppear:或者旧控制器的viewWillDisappear:中强制屏幕方向旋转. 如果, ViewController是在UINavigationController下, 那么强制屏幕旋转的代码需要放在UINavigationController下, 强制屏幕旋转代码如下所示:

```
// 强制转换屏幕方向
- (void)rotateToDirection:(UIInterfaceOrientation)direction
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = direction;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
```




