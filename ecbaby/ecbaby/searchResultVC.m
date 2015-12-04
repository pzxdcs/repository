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


@interface searchResultVC ()<UITableViewDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,assign) int page;
//@property (nonatomic)BOOL isLoadMore;


@end

@implementation searchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.text = _keywards;
    self.title = _keywards;
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.showsVerticalScrollIndicator =
    NO;
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


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.data.count-1) {
        [self reloadmore];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
