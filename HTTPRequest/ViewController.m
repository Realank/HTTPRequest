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
#import <MBProgressHUD.h>
#define HUD_SHOW [MBProgressHUD showHUDAddedTo:self.view animated:YES];
#define HUD_HIDE [MBProgressHUD hideHUDForView:self.view animated:YES];

@interface ViewController()<MapSearchCompleteDelegate, SelectCompleteDelegate>
@property (weak, nonatomic) IBOutlet UITextField *latitudeTF;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTF;
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
@property (weak, nonatomic) IBOutlet UITextField *locationDetailTF;
@property (weak, nonatomic) IBOutlet UITextField *customerTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) CustomModel *companyModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentTV.layer.cornerRadius = 5;
    self.contentTV.layer.borderWidth = 1;
    self.contentTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
    
}

- (void)dismissKeyboard{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (void)keyboardWillShow:(NSNotification *)notification {

    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         
                         weakSelf.bottonConstraint.constant = keyboardRect.size.height + 10;
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         
                        weakSelf.bottonConstraint.constant = 0;
                         
                     }];
}

- (IBAction)submit:(id)sender {
//        [self signWithLatitude:@"39.109019" longitude:@"117.180391" location:@"上海虹桥机场" locationDetail:@"上海虹桥机场" content:@"我在上海虹桥机场"];
    HUD_SHOW;
    [HttpUtil signWithLatitude:self.latitudeTF.text longitude:self.longitudeTF.text location:self.locationTF.text locationDetail:self.locationDetailTF.text content:self.contentTV.text company:_companyModel completed:^(id json, NSData *data, NSString *string) {
        HUD_HIDE;
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dict = (NSDictionary*)json;
            NSString* scode = [dict objectForKey:@"scode"];
            if (![scode isEqualToString:@"0"]) {
                //error
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发送失败" message:@"请去客户端查看实际情况" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [alert show];
            }else{
                //success
                NSLog(@"success");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发送成功" message:@"请去客户端查看实际情况" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [alert show];
            }
            
        }
    } failed:^(NSError *error, NSString *message) {
        HUD_HIDE;
        NSLog(@"错误%@",message);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发送失败" message:@"请去客户端查看实际情况" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }];
}

-(void)SelectCompleteWithCompanyModel:(CustomModel *)company {
    _companyModel = company;
    self.customerTF.text = company.name;
    self.contentTV.text = [NSString stringWithFormat:@"我刚刚拜访了%@",company.name];
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
