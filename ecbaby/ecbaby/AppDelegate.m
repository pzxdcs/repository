//
//  AppDelegate.m
//  ecbaby
//
//  Created by qingyun on 15/11/27.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "AppDelegate.h"
#import <iflyMSC/iflyMSC.h>
#import "common.h"
#define kVersionKey @"Version"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //指定根视图控制器
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self instantiateRootViewController];
    [self.window makeKeyAndVisible];
//    //设置sdk的log等级，log保存在下面设置的工作路径中
//    [IFlySetting setLogFile:LVL_ALL];
//    
//    //打开输出在console的log开关
//    [IFlySetting showLogcat:YES];
//    
//    //设置sdk的工作路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachePath = [paths objectAtIndex:0];
//    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"565c5142"];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    return YES;

}

- (id)instantiateRootViewController{
    //取出app运行的版本
    NSString *currentVer = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //根据存储的标示符，判断应用是否是该版本第一次运行，返回不同的控制器
    //取出本地存储的标示符
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *verson = [userDefault objectForKey:kVersionKey];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([currentVer isEqualToString:verson]) {
        //不是该版本第一次运行，返回tabbar控制器作为主控制器
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"main"];
        return vc;
        
    }else{
        //该版本第一次运行，显示引导页
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"guide"];
        //第一次运行后，存储标示符
        [userDefault setObject:currentVer forKey:kVersionKey];
        [userDefault synchronize];
        return vc;
    }
    
}
-(void)guideEnd{
    //初始化根视图控制器
    UIStoryboard *story = self.window.rootViewController.storyboard;
    self.window.rootViewController = [story instantiateViewControllerWithIdentifier:@"main"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
