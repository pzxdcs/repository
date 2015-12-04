//
//  searchModel.h
//  ecbaby
//
//  Created by qingyun on 15/12/3.
//  Copyright © 2015年 张雪城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchModel : NSObject
@property(strong,nonatomic)NSString *title;
@property(strong, nonatomic)NSString *username;
@property(strong, nonatomic)NSString *content;
@property(strong,nonatomic)NSArray *image;
-(instancetype)initWithDic:(NSDictionary *)dic;

@end
