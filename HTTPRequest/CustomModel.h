//
//  CustomModel.h
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomModel : NSObject

@property (nonatomic,strong) NSString* name;

+(CustomModel*)customModelWithDict:(NSDictionary*) dict;

@end
@protocol CustomModel <NSObject>
@end

@interface CustomSearchModel : NSObject

@property (nonatomic, strong) NSArray<CustomModel> *customs;
@property (nonatomic,strong) NSString* count;

+(CustomSearchModel*)customSearchModelWithDict:(NSDictionary*) dict;
@end