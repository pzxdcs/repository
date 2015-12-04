//
//  collectVC.m
//  ecbaby
//
//  Created by qingyun on 15/12/4.
//  Copyright © 2015年 张雪城. All rights reserved.
//

#import "collectVC.h"
#import "loginModel.h"
#import "AFNetworking.h"
#import "common.h"
#import "searchModel.h"
#import "collectCell.h"
#import "searchDetailVC.h"
@interface collectVC ()
@property(nonatomic, strong)NSArray *data;
@property(nonatomic,assign) int page;


@end

@implementation collectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData{
        NSDictionary *params = @{@"c":@"iosapp",@"a":@"msglist",@"page":@"0",@"userid":[loginModel currentLogin].userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kBaseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    NSDictionary *params = @{@"c":@"iosapp",@"a":@"msglist",@"page":[NSString stringWithFormat:@"%d",_page],@"userid":[loginModel currentLogin].userId};
    
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
    collectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
