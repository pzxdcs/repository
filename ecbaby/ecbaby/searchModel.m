//
//  searchModel.m
//  ecbaby
//
//  Created by qingyun on 15/12/3.
//  Copyright © 2015年 张雪城. All rights reserved.
//

#import "searchModel.h"

@implementation searchModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    self.username = dic[@"username"];
    self.title = dic[@"title"];
    self.content = dic[@"description"];
    self.image = dic[@"images"];
    return self;
}

@end
