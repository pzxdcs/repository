//
//  HomeVC.m
//  ecbaby
//
//  Created by qingyun on 15/11/30.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "HomeVC.h"
#import "loginModel.h"
#import <iflyMSC/iflyMSC.h>
#import "searchResultVC.h"

#import "ISRDataHelper.h"


@interface HomeVC ()<IFlyRecognizerViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginBarButtomItem;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IFlyRecognizerView *iflyRecognizerView;
@property (strong, nonatomic) NSString *result;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLeftView];
    [self setUpVoiceThing];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[loginModel currentLogin]isLogin]) {
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        self.navigationItem.rightBarButtonItem = self.loginBarButtomItem;
    }
    
    _textField.text = @"";
    return;
    


}
- (void)setUpLeftView
{

    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_small"]];
    
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = imageV;
}
- (void)setUpVoiceThing
{
    _result = @"";
    _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    
    //设置代理
    _iflyRecognizerView.delegate = self;
    
    //是否带标点
    [_iflyRecognizerView setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -iflyRecognizerView delegate
-(void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = resultArray[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString *resultFromJson = [ISRDataHelper stringFromJson:resultString];
    _result = [NSString stringWithFormat:@"%@%@",_result,resultFromJson];
    _textField.text = _result;
    if (isLast) {
        if (_textField == nil || [_textField.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
            searchResultVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchResult"];
            [self.navigationController pushViewController:vc animated:YES];
            vc.keywards = _textField.text;
            _result = @"";
        }
        
    }
   

}
-(void)onError:(IFlySpeechError *)error{
    NSLog(@"%@",error);
    
}
- (IBAction)voice:(UIButton *)sender {
    [_iflyRecognizerView start];
}

- (IBAction)editBegin:(UITextField *)sender {
    [UIView animateWithDuration:.32 animations:^{
    self.tabBarController.view.transform = CGAffineTransformMakeTranslation(0, -120);
    }];


}
- (IBAction)editEnd:(UITextField *)sender {
    [UIView animateWithDuration:.32 animations:^{
        self.tabBarController.view.transform = CGAffineTransformIdentity;
    }];
}
- (IBAction)hideKeyBoard:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)go:(UIButton *)sender {
    if (_textField == nil || [_textField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        searchResultVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchResult"];
        [self.navigationController pushViewController:vc animated:YES];
        vc.keywards = _textField.text;

   //     NSLog(@"=======%@======",vc.text);
        
        
    }
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
