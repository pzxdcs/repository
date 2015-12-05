//
//  hotSearchVC.m
//  ecbaby
//
//  Created by qingyun on 15/11/30.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "hotSearchVC.h"
#import "searchResultVC.h"

@interface hotSearchVC ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation hotSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _textfield.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchButton:(UIButton *)sender {
    [self.view endEditing:YES];
    [NSTimer scheduledTimerWithTimeInterval:.3f target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
}
- (void)delayMethod{
    
    if (_textfield == nil || [_textfield.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        searchResultVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchResult"];
        [self.navigationController pushViewController:vc animated:YES];
        vc.keywards = _textfield.text;
        
        //     NSLog(@"=======%@======",vc.text);
        
        
    }
    
    
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
