//
//  MainVC.m
//  ecbaby
//
//  Created by qingyun on 15/11/27.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "MainVC.h"
#import "common.h"
#import "loginModel.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor whiteColor];;
    if ([[loginModel currentLogin] isLogin]) {
    UIViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"like"];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.viewControllers];
        [arr addObject:VC];
        self.viewControllers = arr;

    }else{
        return;

    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:kLogoutNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:kLoginNotification object:nil];

    // Do any additional setup after loading the view.
}
-(void)logout:(NSNotification *)notification{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.viewControllers];
    [arr removeLastObject];
    self.viewControllers = arr;
    
    self.selectedIndex = 0;
    
}
-(void)login:(NSNotification *)notification{
    UIViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"like"];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.viewControllers];
    [arr addObject:VC];
    self.viewControllers = arr;
    self.selectedIndex = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
