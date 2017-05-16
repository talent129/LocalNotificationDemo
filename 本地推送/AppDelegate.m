//
//  AppDelegate.m
//  本地推送
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //请求用户权限 只需要做一次 如果有多个通知发生 注册通知 写在这里
    /*
     typedef NS_OPTIONS(NSUInteger, UIUserNotificationType) {
     UIUserNotificationTypeNone    = 0,      // the application may not present any UI upon a notification being received
     UIUserNotificationTypeBadge   = 1 << 0, // the application may badge its icon upon a notification being received
     UIUserNotificationTypeSound   = 1 << 1, // the application may play a sound upon a notification being received
     UIUserNotificationTypeAlert   = 1 << 2, // the application may display an alert upon a notification being received
     } NS_ENUM_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's UNAuthorizationOptions") __TVOS_PROHIBITED;
     */
    
    // In iOS 8.0 and later, your application must register for user notifications using -[UIApplication registerUserNotificationSettings:] before being able to schedule and present UILocalNotifications
    //NS_CLASS_DEPRECATED_IOS(4_0, 10_0, "Use UserNotifications Framework's UNNotificationRequest") __TVOS_PROHIBITED
    
    //4.注册通知(iOS8以后)
    
    //UIUserNotificationSettings: 通知的设置 注册通知的类型
    
    //创建分类 注意使用可变子类 UIUserNotificationCategory
    UIMutableUserNotificationCategory *category = [UIMutableUserNotificationCategory new];
    
    //设置标识符
    category.identifier = @"category";
    
    //设置前台按钮  注意使用可变子类  点击按钮 能够回到原程序的就是前台
    UIMutableUserNotificationAction *act = [UIMutableUserNotificationAction new];
    
    //设置前台标识符
    act.identifier = @"Foreground";
    
    //设置按钮模式
    /*
     typedef NS_ENUM(NSUInteger, UIUserNotificationActivationMode) {
     UIUserNotificationActivationModeForeground, // activates the application in the foreground
     UIUserNotificationActivationModeBackground  // activates the application in the background, unless it's already in the foreground
     } NS_ENUM_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's UNNotificationActionOptions") __TVOS_PROHIBITED;
     */
    act.activationMode = UIUserNotificationActivationModeForeground;
    
    //设置按钮标题
    act.title = @"前台按钮";
    
    
    //设置后台按钮  注意使用可变子类  点击按钮 不能打开原程序
    UIMutableUserNotificationAction *action = [UIMutableUserNotificationAction new];
    
    //设置前台标识符
    action.identifier = @"Background";
    
    //设置按钮模式
    /*
     typedef NS_ENUM(NSUInteger, UIUserNotificationActivationMode) {
     UIUserNotificationActivationModeForeground, // activates the application in the foreground
     UIUserNotificationActivationModeBackground  // activates the application in the background, unless it's already in the foreground
     } NS_ENUM_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's UNNotificationActionOptions") __TVOS_PROHIBITED;
     */
    action.activationMode = UIUserNotificationActivationModeBackground;
    
    //设置按钮标题
    action.title = @"后台按钮";

    
    //设置按钮  ->多个 2个
    [category setActions:@[act, action] forContext:UIUserNotificationActionContextDefault];
    
    //设置分类集合
    NSSet *set = [NSSet setWithObject:category];
    
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:set];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    
    //1.首次启动 这个值为空 为空则没必要调用通知处理的方法
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        
        //2.获取本地通知
        UILocalNotification *localNoti = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
        
        //3.调用接收通知后 调用方法
        [self changeLocalNoti:localNoti];
    }
    
    return YES;
}

#pragma mark - 处理分类按钮点击
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    NSLog(@"identifier: %@", identifier);
    
    //获取标识符 根据值处理逻辑
}

/*- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification NS_DEPRECATED_IOS(4_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED;
 */
#pragma mark -接收本地通知消息完成时调用
//程序在前台 会调用这个方法 不会显示横幅 自动跳转；
//在后台 这个方法不会被调用 显示横幅 点击系统提示 进入程序前台 则会调用这个方法 跳转
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
    
    [self changeLocalNoti:notification];
    
}

#pragma mark -收到通知后 进行板块的跳转
- (void)changeLocalNoti:(UILocalNotification *)localNoti
{
    //若程序在前台运行时 不应主动跳转 或 给用户提示是否跳转
    
    //判断程序当前状态
    /*
     typedef NS_ENUM(NSInteger, UIApplicationState) {
     UIApplicationStateActive,      激活
     UIApplicationStateInactive,    将要激活
     UIApplicationStateBackground   后台
     } NS_ENUM_AVAILABLE_IOS(4_0);
     */
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        //或给用户提示 是否跳转
        return;
    }
    
    
    //获取信息
    NSString *selectIndexStr = localNoti.userInfo[@"selectIndex"];
    
    //获取根控制器
    UITabBarController *rootVC = (UITabBarController *)self.window.rootViewController;
    
    //切换索引
    rootVC.selectedIndex = [selectIndexStr integerValue];
}

@end
