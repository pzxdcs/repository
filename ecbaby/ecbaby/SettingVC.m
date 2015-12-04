//
//  SettingVC.m
//  ecbaby
//
//  Created by qingyun on 15/11/30.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "SettingVC.h"
#import "loginModel.h"
#import "UITableView+IndexWithIndexPath.h"
#import "common.h"

@interface SettingVC ()
@property (nonatomic, strong)NSArray *cellTitle;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[loginModel currentLogin] isLogin]) {
        
        self.cellTitle = @[@[@"账号管理"],
                           @[@"通知", @"隐私与安全", @"通用设置"],
                           @[@"清理缓存", @"意见反馈", @"关于童星育儿搜"],
                           @[@"退出当前账号"]];
    }else{
        self.cellTitle = @[@[@"通用设置"], @[@"关于童星育儿搜"]];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return self.cellTitle.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellTitle[section] count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
    cell.textLabel.text = self.cellTitle[indexPath.section][indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = [tableView indexWithIndexPath:indexPath];
    switch (index) {
        case 7:
        {
            //退出登录
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"确认退出登录" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //确认退出
                //1.清除登录信息
                [[loginModel  currentLogin] logOut];
                //2.弹出登录界面
                
                //3.切换tabbarVC的选择控制器
                [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:nil];
                //4.返回到之前的页面
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
