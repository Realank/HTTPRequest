//
//  SelectCompanyTableViewController.h
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectCompleteDelegate <NSObject>

- (void)SelectCompleteWithCompanyName:(NSString*)name;

@end

@interface SelectCompanyTableViewController : UITableViewController

@property (nonatomic, weak) id<SelectCompleteDelegate> completeDelegate;
@property (nonatomic, strong) NSString *keyword;

@end
