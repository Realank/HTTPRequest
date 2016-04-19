//
//  SelectCompanyTableViewController.h
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomModel;
@protocol SelectCompleteDelegate <NSObject>

- (void)SelectCompleteWithCompanyModel:(CustomModel*)company;

@end

@interface SelectCompanyTableViewController : UITableViewController

@property (nonatomic, weak) id<SelectCompleteDelegate> completeDelegate;
@property (nonatomic, strong) NSString *keyword;

@end
