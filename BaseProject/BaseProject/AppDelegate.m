//
//  AppDelegate.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"
#import "XunJieNewsNetManager.h"
#import "TheMeViewController.h"
#import "HomePageViewController.h"
#import "TheMeDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initializeWithApplication:application];
//    [XunJieNewsNetManager getTheMeListDatakcompletionHandle:^(id model, NSError *error) {
//        NSLog(@"0000");
//    }];
    
    
    self.window.rootViewController = self.sideMenu;
    [self configGlobalUIStyle]; //配置全局UI样式
    return YES;
}
- (void)configGlobalUIStyle{
    /** 配置导航栏题目的样式 */
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont flatFontOfSize:kNaviTitleFontSize], NSForegroundColorAttributeName: kNaviTitleColor}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
}
/** 代码重构:用代码把功能实现以后，考虑代码结构如何编写可以更加方便后期维护 */
- (UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (RESideMenu *)sideMenu{
    if (!_sideMenu) {
        _sideMenu=[[RESideMenu alloc]initWithContentViewController:[HomePageViewController standardHomePageNavi] leftMenuViewController:[TheMeViewController new] rightMenuViewController:nil];
//        _sideMenu = [[RESideMenu alloc]initWithContentViewController:[TheMeDetailViewController standardHomePageNaviWithTypeId:@"6"] leftMenuViewController:[TheMeViewController new] rightMenuViewController:nil];
        //为sideMenu设置背景图,
        _sideMenu.backgroundImage =[UIImage imageNamed:@"background.jpg"];
        //可以让出现菜单时不显示状态栏
        _sideMenu.menuPrefersStatusBarHidden = YES;
        //不允许菜单栏到了边缘还可以继续缩小
        _sideMenu.bouncesHorizontally = NO;
//        _sideMenu.contentViewInLandscapeOffsetCenterX = kWindowW/2;
//        _sideMenu.contentViewInPortraitOffsetCenterX = 0;
//        _sideMenu.contentViewShadowRadius = 5;
        
        
        
    }
    return _sideMenu;
}

@end
