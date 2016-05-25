//
//  AppDelegate.m
//  3DTouch
//
//  Created by Jing  on 16/5/25.
//  Copyright © 2016年 Jing . All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ShareViewController.h"
#import "SearchViewController.h"
#import "LocationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    ViewController * viewController = [[ViewController alloc] init];
    UINavigationController * navigationViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController  = navigationViewController;
    
#pragma mark -  创建3D touch快捷选项 不写入info.plist文件
    [self creatShortcutItem];
    
#pragma mark -  创建3D touch快捷选项（从info.plist文件获取对应快捷选项标签）
    UIApplicationShortcutItem * shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    // 直接从快捷选项标签启动app
    if (shortcutItem) {
        //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
        if([shortcutItem.type isEqualToString:@"com.jing.touch.home"]){
            
            NSArray * array = @[@"欢迎来到首页"];
            UIActivityViewController * activityViewControlle = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
            [self.window.rootViewController presentViewController:activityViewControlle animated:YES completion:^{
            }];
    
        } else if([shortcutItem.type isEqualToString:@"com.jing.touch.share"]){ //进入分享界面
            
            ShareViewController * shareVc = [[ShareViewController alloc] init];
            [navigationViewController pushViewController:shareVc animated:YES];
            
        } else if ([shortcutItem.type isEqualToString:@"com.jing.touch.search"]) { //进入搜索界面
            SearchViewController * searchVc = [[SearchViewController alloc] init];
            [navigationViewController pushViewController:searchVc animated:YES];
            
        } else if ([shortcutItem.type isEqualToString:@"com.jing.touch.location"]) { //进入定位界面
            LocationViewController * LocationVc = [[LocationViewController alloc] init];
            
            [navigationViewController pushViewController:LocationVc animated:YES];
        }
        return NO;
    } 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

// 如果app仍在后台运行，通过快捷选项标签进入app调用该方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    ViewController * viewController = [[ViewController alloc] init];
    UINavigationController * navigationViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController  = navigationViewController;
#pragma mark -  创建3D touch快捷选项（从info.plist文件获取对应快捷选项标签）
    //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
    if([shortcutItem.type isEqualToString:@"com.jing.touch.home"]){
        
        NSArray * array = @[@"欢迎来到首页"];
        UIActivityViewController * activityViewControlle = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
        [self.window.rootViewController presentViewController:activityViewControlle animated:YES completion:^{
        }];
    } else if([shortcutItem.type isEqualToString:@"com.jing.touch.share"]){ //进入分享界面
        
        ShareViewController * shareVc = [[ShareViewController alloc] init];
        [navigationViewController pushViewController:shareVc animated:YES];
         
         } else if ([shortcutItem.type isEqualToString:@"com.jing.touch.search"]) { //进入搜索界面
        SearchViewController * searchVc = [[SearchViewController alloc] init];
             [navigationViewController pushViewController:searchVc animated:YES];

    } else if ([shortcutItem.type isEqualToString:@"com.jing.touch.location"]) { //进入定位界面
        LocationViewController * LocationVc = [[LocationViewController alloc] init];
        
        [navigationViewController pushViewController:LocationVc animated:YES];
    }
//
    if (completionHandler) {
        completionHandler(YES);
    }
}

#pragma mark -  创建3D touch快捷选项 不写入info.plist文件
- (void)creatShortcutItem {
    
#warning  或是创建自定义图标的icon
    //    UIApplicationShortcutIcon * homeIconBySelf = [UIApplicationShortcutIcon iconWithTemplateImageName:@"自定义图片名称.png"];
    
#warning 采用系统提供的icon
    UIApplicationShortcutIcon * icon = [UIApplicationShortcutIcon iconWithType:(UIApplicationShortcutIconTypeHome)];
    //创建快捷选项
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"com.jing.touch.home" localizedTitle:@"首页" localizedSubtitle:@"进入首页" icon:icon userInfo:nil];
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item];
}

@end
