//
//  searchResultCell.h
//  ecbaby
//
//  Created by qingyun on 15/12/3.
//  Copyright © 2015年 张雪城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class searchModel;

@interface searchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *content;
-(void)setMOdel:(searchModel *)model;
@end
