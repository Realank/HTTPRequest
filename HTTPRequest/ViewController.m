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
#import "MapViewController.h"
#import "SelectCompanyTableViewController.h"

@interface ViewController()<MapSearchCompleteDelegate, SelectCompleteDelegate>
@property (weak, nonatomic) IBOutlet UITextField *latitudeTF;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTF;
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
@property (weak, nonatomic) IBOutlet UITextField *locationDetailTF;
@property (weak, nonatomic) IBOutlet UITextField *customerTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)submit:(id)sender {
//        [self signWithLatitude:@"39.109019" longitude:@"117.180391" location:@"上海虹桥机场" locationDetail:@"上海虹桥机场" content:@"我在上海虹桥机场"];
        [HttpUtil signWithLatitude:self.latitudeTF.text longitude:self.longitudeTF.text location:self.locationTF.text locationDetail:self.locationDetailTF.text content:@"我在上海虹桥机场" completed:^(id json, NSData *data, NSString *string) {
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
}

-(void)SelectCompleteWithCompanyName:(NSString *)name {
    self.customerTF.text = name;
}

-(void)mapSearchCompleteWithLatitude:(NSString *)latitude longitude:(NSString *)longitude location:(NSString *)location andLocationDetail:(NSString *)locationDetail{
    self.latitudeTF.text = latitude;
    self.longitudeTF.text = longitude;
    self.locationTF.text = location;
    self.locationDetailTF.text = locationDetail;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    if ([vc isKindOfClass:[MapViewController class]]) {
        ((MapViewController*)vc).completeDelegate = self;
    }else if ([vc isKindOfClass:[SelectCompanyTableViewController class]]) {
        ((SelectCompanyTableViewController*)vc).completeDelegate = self;
        ((SelectCompanyTableViewController*)vc).keyword = self.customerTF.text;
    }
}

//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
////    [self signWithLatitude:@"39.109019" longitude:@"117.180391" location:@"上海虹桥机场" locationDetail:@"上海虹桥机场" content:@"我在上海虹桥机场"];
//    [HttpUtil signWithLatitude:@"39.109019" longitude:@"117.180391" location:@"上海虹桥机场" locationDetail:@"上海虹桥机场" content:@"我在上海虹桥机场" completed:^(id json, NSData *data, NSString *string) {
//        if ([json isKindOfClass:[NSDictionary class]]) {
//            NSDictionary* dict = (NSDictionary*)json;
//            NSString* scode = [dict objectForKey:@"scode"];
//            if (![scode isEqualToString:@"0"]) {
//                //error
//            }else{
//                //success
//                NSLog(@"success");
//            }
//        }
//    } failed:^(NSError *error, NSString *message) {
//        NSLog(@"错误%@",message);
//    }];
////    [HttpUtil findPlaceWithKeyword:@"信" completed:^(id json, NSData *data, NSString *string) {
////        CustomSearchModel* model = [CustomSearchModel customSearchModelWithDict:json];
////        NSLog(@"%@",model);
////    } failed:^(NSError *error, NSString *message) {
////        NSLog(@"错误%@",message);
////    }];
//}

@end
