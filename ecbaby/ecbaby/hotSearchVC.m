//
//  hotSearchVC.m
//  ecbaby
//
//  Created by qingyun on 15/11/30.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "hotSearchVC.h"
#import "searchResultVC.h"
#import "AFNetworking.h"
#import "common.h"
#import "hotSearchCollectionCell.h"
#import "searchResultVC.h"
#define kColorRandom(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:.8]



@interface hotSearchVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *data;


@end

@implementation hotSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)loadData{
    NSDictionary *param = @{@"c":@"iosapp",@"a":@"labels"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kBaseURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = [NSArray arrayWithArray:responseObject[@"data"]];
        self.data = arr;
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _textfield.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    hotSearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    cell.backgroundColor = kColorRandom(r,g,b);
    cell.layer.cornerRadius = 35;
    cell.nameLabel.text = self.data[indexPath.row][@"labelname"];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    searchResultVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchResult"];
    [self.navigationController pushViewController:vc animated:YES];
    vc.keywards = self.data[indexPath.row][@"labelname"];
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
