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
#import "ScrollDisplayViewController.h"

@interface AppDelegate ()<ScrollDisplayViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initializeWithApplication:application];
//    [XunJieNewsNetManager getTheMeListDatakcompletionHandle:^(id model, NSError *error) {
//        NSLog(@"0000");
//    }];
    
    
    [self welcome];
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
- (void)welcome
{
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    /*
     版本号:
     version:正式发布版本号，用户只能看到version
     build:测试版本号，是对于程序员来说的
     */
    //    NSLog(@"infoDic %@", infoDic);
    NSString *key =@"CFBundleShortVersionString";
    NSString *currentVersion=infoDic[key];
    //已运行过的版本号需要持久化处理，通常存储在userDefault中
    NSString *runVersion=[[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (runVersion==nil || ![runVersion isEqualToString:currentVersion] ) {
        //没运行过 或者 版本号不一致，则显示欢迎页
        NSLog(@"显示欢迎页,window根视图设置为欢迎控制器对象");
        //创建图片数组
        UIViewController *welcome = [[UIViewController alloc]init];
        self.window.rootViewController = welcome;
        [self.window makeKeyWindow];
        welcome.view.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        NSArray *welcomeImgs = @[@"welcome1",@"welcome2",@"welcome3",@"welcome4"];
        ScrollDisplayViewController *WelcomeScroll = [[ScrollDisplayViewController alloc]initWithImgNames:welcomeImgs];
        WelcomeScroll.canCycle = NO;
        WelcomeScroll.autoCycle = NO;
        WelcomeScroll.location = 2;
        WelcomeScroll.delegate = self;
        [welcome addChildViewController:WelcomeScroll];
        [welcome.view addSubview:WelcomeScroll.view];
        [WelcomeScroll.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(welcome.view);
        }];
        //保存新的版本号,防止下次运行再显示欢迎页
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
    }else{
        self.window.rootViewController = self.sideMenu;
    }

}
#pragma mark -
- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController didSelectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    if (index == 3) {
        self.window.rootViewController = self.sideMenu;
    }
}

@end
