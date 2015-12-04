//
//  loginModel.h
//  ecbaby
//
//  Created by qingyun on 15/11/30.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginModel : NSObject<NSCoding>
@property(nonatomic, strong)NSString *userName;
@property(nonatomic, strong)NSString *userId;

+(instancetype)currentLogin;
//保存登录信息
-(void)saveLoginInfo:(NSDictionary *)dic;
//判断登录状态
-(BOOL)isLogin;
-(void)logOut;



@end
