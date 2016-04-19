//
//  CustomModel.m
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "CustomModel.h"

@implementation CustomModel

+(CustomModel*)customModelWithDict:(NSDictionary*) dict{
    if (!dict) {
        return nil;
    }
    NSString* name = [dict objectForKey:@"name"];
    NSString* ids = [dict objectForKey:@"id"];
    if (name.length > 0) {
        CustomModel* model = [[self alloc]init];
        model.name = name;
        model.ids = ids;
        return model;
    }
    return nil;
}

@end

@implementation CustomSearchModel

+(CustomSearchModel*)customSearchModelWithDict:(NSDictionary*) dict{
    if (!dict) {
        return nil;
    }
    
    NSString* scode = [dict objectForKey:@"scode"];
    if (![scode isEqualToString:@"0"]) {
        return nil;
    }
    NSDictionary* body = [dict objectForKey:@"body"];
    if (body && [body isKindOfClass:[NSDictionary class]]) {
        NSArray* accounts = [body objectForKey:@"accounts"];
        if (accounts.count>0) {
            NSMutableArray *accountsArr = [NSMutableArray array];
            for (NSDictionary* account in accounts) {
                CustomModel *accountModel = [CustomModel customModelWithDict:account];
                if (accountModel) {
                    [accountsArr addObject:accountModel];
                }
            }
            if (accountsArr.count > 0) {
                CustomSearchModel *model = [[CustomSearchModel alloc]init];
                model.customs = [accountsArr copy];
                long count = [[body objectForKey:@"count"] integerValue];
                if (count > 0) {
                    model.count = [NSString stringWithFormat:@"%ld",count];
                    return model;
                }
            }
        }
    }
    return nil;
}


@end
