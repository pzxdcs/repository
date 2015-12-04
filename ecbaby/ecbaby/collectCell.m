//
//  collectCell.m
//  ecbaby
//
//  Created by qingyun on 15/12/4.
//  Copyright © 2015年 张雪城. All rights reserved.
//

#import "collectCell.h"
#import "searchModel.h"
#import "UIImageView+WebCache.h"

@implementation collectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMOdel:(searchModel *)model{
    self.username.text = model.username;
    self.title.text = model.title;
    self.content.text = model.content;
    NSString *urlstr = [model.image[0]stringByAppendingString:@"_middle.jpg"];
    NSURL *url = [NSURL URLWithString:urlstr];
    [self.image sd_setImageWithURL:url];
    
     
}

@end
