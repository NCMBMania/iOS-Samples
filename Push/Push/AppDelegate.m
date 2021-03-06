//
//  AppDelegate.m
//  Push
//
//  Created by 中津川 篤司 on 2014/04/18.
//  Copyright (c) 2014年 Atsushi Nakatsugawa. All rights reserved.
//

#import "AppDelegate.h"
#import <NCMB/NCMB.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // [NCMB setApplicationKey:@"your_application_key" clientKey:@"your_client_key"];
    
    [NCMB setApplicationKey:@"e617bee762e6c0799d20bc3ef45ead1ee87c99276c482a3c5b6b90e013d8a669" clientKey:@"65c3eb97f9fe9e90bba279611d405121ddc1ea9beaea92ea77ee7ceb02b91247"];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    [NCMBPush handleRichPush:[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"]];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// 配信端末情報を登録する。
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Registerd.")
    NCMBInstallation *currentInstallation = [NCMBInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation save];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    if ([userInfo.allKeys containsObject:@"com.nifty.RichUrl"]){
        if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive){
            [NCMBPush handleRichPush:userInfo];
        }
    }
}

// 通知に関するエラー時はこちら
- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
