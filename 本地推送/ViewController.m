//
//  ViewController.m
//  本地推送
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "ViewController.h"
//#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
}

- (void)localNotificationWithBody:(NSString *)alertBody withUserInfo:(NSDictionary *)userInfo withBadge:(NSInteger)badge
{
    //1.创建本地推送通知对象
    UILocalNotification *localNoti = [UILocalNotification new];
    
    //2.设置属性
    //触发时间
    localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    
    //通知的具体内容
    localNoti.alertBody = alertBody;
    
    //音效文件名
    localNoti.soundName = UILocalNotificationDefaultSoundName;
    
    //角标数量
    localNoti.applicationIconBadgeNumber = badge;
    
    //点击推送通知打开app时显示的启动图片
    //    localNoti.alertLaunchImage = @"";
    
    //附加的额外信息
    localNoti.userInfo = userInfo;
    
    //时区
    //    localNoti.timeZone =
    
    //不常用属性
    localNoti.hasAction = YES;
    //锁屏时 显示的动作标题
    localNoti.alertAction = @"滑动来...";
    
    //分类
    localNoti.category = @"category";//和AppDelegate中标识符一致
    
    //    //每隔多久发一次 如果设置了重复调度 调度池不会自动销毁通知
    //    localNoti.repeatInterval = NSCalendarUnitMinute;//日历组件
    //    //重复所依据的日历  公里 阴历
    //    localNoti.repeatCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    //
    //删除所有通知
    //    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //取消调度本地推送通知
    //首先获取所有本地通知  并删除 / 删除重复的通知 / 还未执行的通知
    //    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //
    //    //遍历
    //    for (UILocalNotification *noti in array) {
    //        //根据条件确定是否是自己要取消的通知
    //        if (noti.userInfo) {
    //            [[UIApplication sharedApplication] cancelLocalNotification:localNoti];
    //        }
    //    }
    
    //立即发出本地推送通知
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:localNoti];
    
    
    //3.调度本地推送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
    
    //获得被调度的所有本地推送通知
//    [[UIApplication sharedApplication] scheduledLocalNotifications];
    
}


- (IBAction)button1Action:(id)sender {
    
    [self localNotificationWithBody:@"button1" withUserInfo:@{@"selectIndex" : @1} withBadge:22];
}


- (IBAction)button2Action:(id)sender {
    
    [self localNotificationWithBody:@"button2" withUserInfo:@{@"selectIndex" : @2} withBadge:66];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
