//
//  ViewController.m
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "ViewController.h"
#import "HttpUtil.h"
#import "CustomModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self signWithLatitude:@"39.109019" longitude:@"117.180391" location:@"上海虹桥机场" locationDetail:@"上海虹桥机场" content:@"我在上海虹桥机场"];
    [HttpUtil signWithLatitude:@"39.109019" longitude:@"117.180391" location:@"上海虹桥机场" locationDetail:@"上海虹桥机场" content:@"我在上海虹桥机场" completed:^(id json, NSData *data, NSString *string) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dict = (NSDictionary*)json;
            NSString* scode = [dict objectForKey:@"scode"];
            if (![scode isEqualToString:@"0"]) {
                //error
            }else{
                //success
                NSLog(@"success");
            }
        }
    } failed:^(NSError *error, NSString *message) {
        NSLog(@"错误%@",message);
    }];
//    [HttpUtil findPlaceWithKeyword:@"信" completed:^(id json, NSData *data, NSString *string) {
//        CustomSearchModel* model = [CustomSearchModel customSearchModelWithDict:json];
//        NSLog(@"%@",model);
//    } failed:^(NSError *error, NSString *message) {
//        NSLog(@"错误%@",message);
//    }];
}

//
//- (void)request {
//    NSArray *key = @[@"_vs",@"appType",@"appVersion",@"inhouse",@"os",@"source"];
//    NSArray *value = @[@"3.6",@"0",@"3.6",@"0",@"iPhone OS,9.2,iPhone",@"2"];
//    NSDictionary *params = [NSDictionary dictionaryWithObjects:value forKeys:key];
//    // Do any additional setup after loading the view, typically from a nib.
//    [HttpUtil send_request:@"https://crm.xiaoshouyi.com/mobile/menu/crm.action" post:NO params:params completed:^(id json, NSData *data, NSString *string) {
//        
//    } failed:^(NSError *error, NSString *message) {
//        
//    }];
//}
//- (void)request2 {
//    
//    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"x-ienterprise-passport" forKey:NSHTTPCookieName];
//    [cookieProperties setObject:@"\"OZyhI1Jf1uZ956mtStf1DqymMkfBjFXV4WRCV2c5AB4=\"" forKey:NSHTTPCookieValue];
//    [cookieProperties setObject:@"crm.xiaoshouyi.com" forKey:NSHTTPCookieDomain];
//    [cookieProperties setObject:@"crm.xiaoshouyi.com" forKey:NSHTTPCookieOriginURL];
//    [cookieProperties setObject:@"/mobile/" forKey:NSHTTPCookiePath];
//    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
////    [cookieProperties setObject:@"OZyhI1Jf1uZ956mtStf1DqymMkfBjFXV4WRCV2c5AB4=" forKey:@"x-ienterprise-passport"];
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    
//    
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        NSLog(@"%@", cookie);
//    }
//    NSArray *key = @[@"_vs",@"appType",@"appVersion",@"inhouse",@"os",@"source"];
//    NSArray *value = @[@"3.6",@"0",@"3.6",@"0",@"iPhone OS,9.2,iPhone",@"2"];
//    NSDictionary *params = [NSDictionary dictionaryWithObjects:value forKeys:key];
//    // Do any additional setup after loading the view, typically from a nib.
//    [HttpUtil send_request:@"https://crm.xiaoshouyi.com/mobile/reminder/all.action" post:YES params:params completed:^(id json, NSData *data, NSString *string) {
//        
//    } failed:^(NSError *error, NSString *message) {
//        
//    }];
//}
//
//- (void)request3 {
//    
//    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"x-ienterprise-passport" forKey:NSHTTPCookieName];
//    [cookieProperties setObject:@"\"OZyhI1Jf1uZ956mtStf1DqymMkfBjFXV4WRCV2c5AB4=\"" forKey:NSHTTPCookieValue];
//    [cookieProperties setObject:@"crm.xiaoshouyi.com" forKey:NSHTTPCookieDomain];
//    [cookieProperties setObject:@"crm.xiaoshouyi.com" forKey:NSHTTPCookieOriginURL];
//    [cookieProperties setObject:@"/mobile/" forKey:NSHTTPCookiePath];
//    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//    //    [cookieProperties setObject:@"OZyhI1Jf1uZ956mtStf1DqymMkfBjFXV4WRCV2c5AB4=" forKey:@"x-ienterprise-passport"];
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    
//    
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        NSLog(@"%@", cookie);
//    }
//    NSArray *key = @[@"_vs",@"appType",@"appVersion",@"inhouse",@"os",@"source",@"activityTypeId",@"arItemIds",@"arSystemId",@"content",@"feedStamp",@"latitude",@"location",@"locationDetail",@"longitude"];
//    NSArray *value = @[@"3.6",@"0",@"3.6",@"0",@"iPhone OS,9.2,iPhone",@"2",@"2334971",@"3324360",@"510",@"我刚刚拜访了上海讯桥通信技术有限公司",@"1452048393742",@"39.109019",@"天津市和平区天津广播电视台(卫津路)",@"天津广播电视台(卫津路)",@"117.180391"];
//    NSDictionary *params = [NSDictionary dictionaryWithObjects:value forKeys:key];
//    // Do any additional setup after loading the view, typically from a nib.
//    [HttpUtil send_request:@"https://crm.xiaoshouyi.com/mobile/activity-record-new/multiAdd-batch.action" post:YES params:params completed:^(id json, NSData *data, NSString *string) {
//        
//    } failed:^(NSError *error, NSString *message) {
//        
//    }];
//}




@end
