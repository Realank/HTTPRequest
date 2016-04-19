//
//  HttpUtil.m
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "HttpUtil.h"
#import "CustomModel.h"


@implementation HttpUtil


+ (void)signWithLatitude:(NSString*)latitude longitude:(NSString*)longitude location:(NSString*)location locationDetail:(NSString*)locationDetail content:(NSString*)content company:(CustomModel*)company completed:(KKSucceedBlock)succeed failed:(KKFailedBlock)failed{
    
    location = [location stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    locationDetail = [locationDetail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    content = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"x-ienterprise-passport" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"\"GEPn3pAcZcWzwZpl4RBsa0b441KEEPJEmRZfFAwDdVo=\"" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"crm.xiaoshouyi.com" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"crm.xiaoshouyi.com" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/mobile/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    //    [cookieProperties setObject:@"OZyhI1Jf1uZ956mtStf1DqymMkfBjFXV4WRCV2c5AB4=" forKey:@"x-ienterprise-passport"];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"%@", cookie);
    }
    NSArray *key = @[@"_vs",@"appType",@"appVersion",@"inhouse",@"os",@"source",@"activityTypeId",@"arItemIds",@"arSystemId",@"content",@"feedStamp",@"latitude",@"location",@"locationDetail",@"longitude"];
    //    NSArray *value = @[@"3.6",@"0",@"3.6",@"0",@"iPhone OS,9.2,iPhone",@"2",@"2334971",@"3324360",@"510",@"shanghaixinqiaotongxin",[self timeStamp],@"39.109019",@"shanghailujiazui",@"shanghailujiazui",@"117.180391"];
    NSArray *value = @[@"4.0",@"0",@"4.0",@"0",@"iPhone OS,9.3.1,iPhone 6",@"2",@"2468482",company.ids,@"510",content,[self timeStamp],latitude,location,locationDetail,longitude];
    NSDictionary *params = [NSDictionary dictionaryWithObjects:value forKeys:key];
    // Do any additional setup after loading the view, typically from a nib.
    [HttpUtil send_request:@"https://crm.xiaoshouyi.com/mobile/activity-record-new/multiAdd-batch.action" post:YES params:params completed:^(id json, NSData *data, NSString *string) {
        if ( succeed ) {
            succeed(json, data, string);
        }
    } failed:^(NSError *error, NSString *message) {
        if (failed) {
            failed(error,message);
        }
    }];
    
    
}

+(NSString*)timeStamp {
    NSDate *now = [NSDate date];
    NSTimeInterval interval= [now timeIntervalSince1970];
    return [NSString stringWithFormat:@"%lld",(long long int)(interval*1000)];
}

+ (void)findPlaceWithKeyword:(NSString*)keyword completed:(KKSucceedBlock)succeed failed:(KKFailedBlock)failed{
    
    keyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"x-ienterprise-passport" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"\"GEPn3pAcZcWzwZpl4RBsa0b441KEEPJEmRZfFAwDdVo=\"" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"crm.xiaoshouyi.com" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"crm.xiaoshouyi.com" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/mobile/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    //    [cookieProperties setObject:@"OZyhI1Jf1uZ956mtStf1DqymMkfBjFXV4WRCV2c5AB4=" forKey:@"x-ienterprise-passport"];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"%@", cookie);
    }
    NSArray *key = @[@"_vs",@"appType",@"appVersion",@"inhouse",@"os",@"source",@"page",@"size",@"key"];
    NSArray *value = @[@"4.0",@"0",@"4.0",@"0",@"iPhone OS,9.2,iPhone",@"2",@"1",@"20",keyword];
    NSDictionary *params = [NSDictionary dictionaryWithObjects:value forKeys:key];
    // Do any additional setup after loading the view, typically from a nib.
    [HttpUtil send_request:@"https://crm.xiaoshouyi.com/mobile/account/search.action" post:YES params:params completed:^(id json, NSData *data, NSString *string) {
        if ( succeed ) {
            succeed(json, data, string);
        }
    } failed:^(NSError *error, NSString *message) {
        if (failed) {
            failed(error,message);
        }
    }];
    
    
}




+ (AFHTTPRequestOperation *)send_request:(NSString *)request post:(BOOL)post params:(id)params
                               completed:(KKSucceedBlock)succeed failed:(KKFailedBlock)failed {
    
    if ( [params isKindOfClass:NSDictionary.class] ) {
        NSMutableString *param = [NSMutableString stringWithCapacity:1];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [param appendFormat:@"%@=%@", key, obj];
            [param appendString:@"&"];
        }];
        NSLog(@"Request URL & params : \n\n%@?%@", request, param);
    }
    else {
        NSLog(@"Request URL : \n\n%@", request);
    }
    
    // 创建request请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置连接请求超时时间
    manager.requestSerializer.timeoutInterval = 10.0f;
    // 申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 解析加密的HTTPS网络请求数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html", nil];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    AFHTTPRequestOperation *operation = nil;
    // post请求
    if ( post ) {
        
        operation = [manager POST:request parameters:params
                          success:^( AFHTTPRequestOperation *operation, id responseObject ) {
                              if ( succeed ) {
                                  succeed(responseObject, operation.responseData, operation.responseString);
                              }
                          }
                          failure:^( AFHTTPRequestOperation *operation, NSError *error ) {
                              if ( failed ) {
                                  failed( error, nil );
                              }
                          }];
    }
    else {
        
        operation = [manager GET:request parameters:params
                         success:^( AFHTTPRequestOperation *operation, id responseObject ) {
                             if ( succeed ) {
                                 succeed(responseObject, operation.responseData, operation.responseString);
                             }
                         }
                         failure:^( AFHTTPRequestOperation *operation, NSError *error ) {
                             if ( failed ) {
                                 failed( error, nil );
                             }
                         }];
    }
    
    //DLog(@"HTTP HEADER : ", manager.requestSerializer.allHTTPHeaderFields);
    
    //设置返回数据的解析方式
    //operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:kNilOptions];
    return operation;
}


@end
