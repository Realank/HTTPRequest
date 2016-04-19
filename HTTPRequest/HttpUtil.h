//
//  HttpUtil.h
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^KKSucceedBlock)( id json, NSData *data, NSString *string );
typedef void (^KKFailedBlock)( NSError *error, NSString *message );

@class CustomModel;
@interface HttpUtil : NSObject

+ (AFHTTPRequestOperation *)send_request:(NSString *)request post:(BOOL)post params:(id)params completed:(KKSucceedBlock)succeed failed:(KKFailedBlock)failed;

+ (void)signWithLatitude:(NSString*)latitude longitude:(NSString*)longitude location:(NSString*)location locationDetail:(NSString*)locationDetail content:(NSString*)content company:(CustomModel*)company completed:(KKSucceedBlock)succeed failed:(KKFailedBlock)failed;

+ (void)findPlaceWithKeyword:(NSString*)keyword completed:(KKSucceedBlock)succeed failed:(KKFailedBlock)failed;
@end
