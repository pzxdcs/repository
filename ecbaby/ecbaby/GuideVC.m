//
//  GuideVC.m
//  ecbaby
//
//  Created by qingyun on 15/11/27.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "GuideVC.h"
#import "AppDelegate.h"
#define w [UIScreen mainScreen].bounds.size.width
#define h  [UIScreen mainScreen].bounds.size.height

@interface GuideVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(w *3, h);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator =  NO;
    self.scrollView.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ScrollView delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {

           self.pageControl.currentPage = self.scrollView.contentOffset.x/w;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
          self.pageControl.currentPage = self.scrollView.contentOffset.x/w;
}
- (IBAction)start:(UIButton *)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    [delegate guideEnd];
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
