//
//  loginVC.m
//  ecbaby
//
//  Created by qingyun on 15/11/30.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "loginVC.h"
#import "AFNetworking.h"
#import "common.h"
#import "loginModel.h"


@interface loginVC ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}
-(void)loadData{
    NSDictionary *params = @{@"c":@"iosapp",@"a":@"login",@"username":_userName.text,@"pwd":_pwd.text};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kBaseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        //保存登录信息
        [[loginModel currentLogin]saveLoginInfo:responseObject];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(UIButton *)sender {
    [self loadData];
}
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
