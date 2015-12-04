//
//  searchResultVC.m
//  ecbaby
//
//  Created by qingyun on 15/12/3.
//  Copyright © 2015年 张雪城. All rights reserved.
//

#import "searchResultVC.h"
#import "AFNetworking.h"
#import "searchModel.h"
#import "common.h"
#import "searchResultCell.h"
#import "searchDetailVC.h"


@interface searchResultVC ()<UITableViewDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property(nonatomic,assign) int page;
//@property (nonatomic)BOOL isLoadMore;


@end

@implementation searchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.text = _keywards;
    self.title = @"搜索结果";
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.showsVerticalScrollIndicator =
    NO;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (IBAction)search:(UIButton *)sender {
    //NSLog(@"%@",_textField.text);
    _keywards = _textField.text;
    [self loadData];
}

-(void)loadData{
    NSDictionary *params = @{@"c":@"iosapp",@"a":@"msglist",@"keywards":_keywards,@"page":@"0"};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kBaseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"======%@=======",responseObject);
        NSArray * arr = [NSArray arrayWithArray:responseObject[@"data"]];
        NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            searchModel *model = [[searchModel alloc]initWithDic:obj];
            [resultArr addObject:model];
            
        }];
        self.data = resultArr;
        [self.tableView reloadData];
        _page = 1;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}
-(void)reloadmore{
 
    _page ++;
    NSDictionary *params = @{@"c":@"iosapp",@"a":@"msglist",@"keywards":_keywards,@"page":[NSString stringWithFormat:@"%d",_page]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kBaseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"======%@=======",responseObject);
        NSArray * arr = [NSArray arrayWithArray:responseObject[@"data"]];
     
        NSMutableArray *resultArr = [NSMutableArray array];
        [resultArr addObjectsFromArray:self.data];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            searchModel *model = [[searchModel alloc]initWithDic:obj];
            [resultArr addObject:model];
        }];
        self.data = resultArr;

        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    searchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    [cell setMOdel:self.data[indexPath.row]];
    

    
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    searchDetailVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
    [self.navigationController pushViewController:VC animated:YES];
    searchModel *model = self.data[indexPath.row];
    VC.titl = model.title;
    VC.username = model.username;
    VC.content = model.content;
    VC.urlstr = [model.image[0]stringByAppendingString:@"_large.jpg"];
    
  
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.data.count-3) {
        [self reloadmore];
    }
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}


@end
