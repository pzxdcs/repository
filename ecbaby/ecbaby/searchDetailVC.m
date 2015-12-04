//
//  searchDetailVC.m
//  ecbaby
//
//  Created by qingyun on 15/12/4.
//  Copyright © 2015年 张雪城. All rights reserved.
//

#import "searchDetailVC.h"
#import "searchModel.h"
#import "searchResultCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+TextHeight.h"


@interface searchDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation searchDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = _titl;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    searchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    cell.title.text = _titl;
    cell.content.text = _content;
    cell.username.text = _username;
    NSURL *url = [NSURL URLWithString:_urlstr];
    [cell.image sd_setImageWithURL:url];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize titleSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width, MAXFLOAT);
    CGFloat titleHeight = [_titl HeightWithSize:titleSize Font:[UIFont systemFontOfSize:17]];
    CGSize usernameSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-30, MAXFLOAT);
    CGFloat usernameHeight = [_username HeightWithSize:usernameSize Font:[UIFont systemFontOfSize:14]];
    CGSize contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-16, MAXFLOAT);
    CGFloat contentHeight = [_content HeightWithSize:contentSize Font:[UIFont systemFontOfSize:14]];
    CGFloat cellHeight = titleHeight+usernameHeight+contentHeight+2+7+10+200+20+8;
    return cellHeight;
      
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
