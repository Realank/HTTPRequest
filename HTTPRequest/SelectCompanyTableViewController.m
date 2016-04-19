//
//  SelectCompanyTableViewController.m
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "SelectCompanyTableViewController.h"
#import "HttpUtil.h"
#import "CustomModel.h"
#import <MBProgressHUD.h>
#define HUD_SHOW [MBProgressHUD showHUDAddedTo:self.view animated:YES];
#define HUD_HIDE [MBProgressHUD hideHUDForView:self.view animated:YES];

@interface SelectCompanyTableViewController ()

@property (nonatomic, strong) NSArray *customerArr;

@end

@implementation SelectCompanyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD_SHOW;
     __weak __typeof(self) weakSelf = self;
    [HttpUtil findPlaceWithKeyword:self.keyword completed:^(id json, NSData *data, NSString *string) {
        CustomSearchModel* model = [CustomSearchModel customSearchModelWithDict:json];
        NSLog(@"%@",model);
        weakSelf.customerArr = model.customs;
        [weakSelf.tableView reloadData];
        HUD_HIDE;
    } failed:^(NSError *error, NSString *message) {
        HUD_HIDE;
        NSLog(@"错误%@",message);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.customerArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    CustomModel *model = [self.customerArr objectAtIndex:row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    CustomModel *model = [self.customerArr objectAtIndex:row];
    if (self.completeDelegate) {
        [self.completeDelegate SelectCompleteWithCompanyModel:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
