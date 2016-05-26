# 3DTouchDemo
This demo expound the some of the 3 dtouch development methods
#plist文件中，添加静态标签如下项
```
{ 
"UIApplicationShortcutItems":[
"Item0":{
"UIApplicationShortcutItemTitle"："标签标题（必填）",
"UIApplicationShortcutItemType"："标签的唯一标识 （必填）",
"UIApplicationShortcutItemIconType"："使用系统图标的类型（可选）",
"UIApplicationShortcutItemIcon File"："使用项目中的图片作为标签图标 （可选）",
"UIApplicationShortcutItemSubtitle"："标签副标题 （可选）",
"UIApplicationShortcutItemUserInfo"："字典信息，如传值使用 （可选）"
 }
]
}
```

#除了静态标签外，也可以在工程中添加动态标签例如
#warning  或是创建自定义图标的icon
    //    UIApplicationShortcutIcon * homeIconBySelf = [UIApplicationShortcutIcon iconWithTemplateImageName:@"自定义图片名称.png"];
    
#warning 采用系统提供的icon
    UIApplicationShortcutIcon * icon = [UIApplicationShortcutIcon iconWithType:(UIApplicationShortcutIconTypeHome)];
    //创建快捷选项
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"com.jing.touch.home" localizedTitle:@"首页" localizedSubtitle:@"进入首页" icon:icon userInfo:nil];
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item];
在AppDelegate.m文件中加如下代码：
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    ViewController * viewController = [[ViewController alloc] init];
    UINavigationController * navigationViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController  = navigationViewController;
    
#pragma mark -  创建3D touch快捷选项 不写入info.plist文件
    UIApplicationShortcutIcon * icon = [UIApplicationShortcutIcon iconWithType:(UIApplicationShortcutIconTypeHome)];
    //创建快捷选项
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"com.jing.touch.home" localizedTitle:@"首页" localizedSubtitle:@"进入首页" icon:icon userInfo:nil];
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item];
    
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

