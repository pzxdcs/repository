//
//  searchDetailCell.h
//  ecbaby
//
//  Created by qingyun on 15/12/4.
//  Copyright © 2015年 张雪城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
