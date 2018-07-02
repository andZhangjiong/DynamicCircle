//
//  AppDelegate.m
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import "AppDelegate.h"

#import "HXDynamicController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[HXDynamicController alloc] init];
    [self.window makeKeyAndVisible];
    
    [self setSVProgressHUD];
    
    return YES;
}

- (void)setSVProgressHUD
{
    [SVProgressHUD setSuccessImage:nil];
    [SVProgressHUD setErrorImage:nil];
    
    // 1、SVProgressHUDMaskTypeNone 透明背景，且有穿透性（不影响交互）
    // 2、SVProgressHUDMaskTypeClear 透明背景，无穿透性（阻碍交互）
    // 3、SVProgressHUDMaskTypeBlack 透明黑色背景，无穿透性（阻碍交互）
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
    // 1、SVProgressHUDStyleLight 白色hud，黑色文字，黑色转圈
    // 2、SVProgressHUDStyleDark 黑色hud，白色文字，白色转圈
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    // 1、SVProgressHUDAnimationTypeNative：系统原生转圈；
    // 2、SVProgressHUDAnimationTypeFlat（环形转圈）
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    // 最小显示时长
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    // 最大显示时长
    [SVProgressHUD setMaximumDismissTimeInterval:3];
    // 设置字体
    [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:16]];
    // 触觉反馈
    [SVProgressHUD setHapticsEnabled:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
