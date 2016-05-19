//
//  AppDelegate.m
//  NetEaseHome
//
//  Created by ZHOUPENGFEI on 16/4/28.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
@interface AppDelegate ()

@property(nonatomic,assign)UIBackgroundTaskIdentifier backgroundIdentifier;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [MobClick startWithAppkey:@"57230436e0f55ad314000c23" reportPolicy:SEND_INTERVAL channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    UIUserNotificationSettings * notiification =   [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notiification];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    if (self.backgroundIdentifier != UIBackgroundTaskInvalid){
        [application endBackgroundTask:self.backgroundIdentifier];
        self.backgroundIdentifier = UIBackgroundTaskInvalid;
    }
    
  self.backgroundIdentifier =   [application beginBackgroundTaskWithExpirationHandler:^{
      [application endBackgroundTask:self.backgroundIdentifier];
      self.backgroundIdentifier = UIBackgroundTaskInvalid;
  }];
  
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];

}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSURLSession * sesson = [NSURLSession sharedSession];
    [sesson dataTaskWithURL:[NSURL URLWithString:@"http://api.k780.com:88/?app=life.time&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString * relult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        UILocalNotification * localNotificaion = [[UILocalNotification alloc] init];
        localNotificaion.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
        localNotificaion.timeZone = [NSTimeZone localTimeZone];
        localNotificaion.alertTitle = @"通知";
        localNotificaion.alertBody = @"aaaaasdfdasfasdasdfafs";
        localNotificaion.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotificaion];
        

        if (error != nil){
            completionHandler(UIBackgroundFetchResultFailed);
        }else{
             completionHandler(UIBackgroundFetchResultNewData);
        }
    }];
    
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
