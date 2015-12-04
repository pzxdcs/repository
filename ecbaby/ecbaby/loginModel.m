//
//  loginModel.m
//  ecbaby
//
//  Created by qingyun on 15/11/30.
//  Copyright (c) 2015年 张雪城. All rights reserved.
//

#import "loginModel.h"
#import "common.h"
#import "NSString+DocumentFilePath.h"
#define kLoginFileName @"loginInfo"
#define kUserName  @"username"
#define kUserId      @"userid"

@implementation loginModel
    
+(instancetype)currentLogin{
     static loginModel *login;
    //单次运行代码块

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [NSString filePathWithName:kLoginFileName];
        login = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (!login) {
            login = [[loginModel alloc]init];
        }
    });
    return login;
}

-(void)saveLoginInfo:(NSDictionary *)dic{
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = dic[@"data"];
    self.userName = dict[kUserName];
    self.userId = dict[kUserId];
    //保存到物理对象中
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //文件路径
    NSString *filePah = [documentPath stringByAppendingPathComponent:kLoginFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:filePah];
    
}
-(BOOL)isLogin{
    if (self.userId) {
        return YES;
    }
    return NO;
}
-(void)logOut{
    self.userId = nil;
    self.userName = nil;
    //删除归档文件
    NSString *filePath = [NSString filePathWithName:kLoginFileName];
    [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
    
}
#pragma mark - coding
-(id)initWithCoder:(NSCoder *)aDecoder{
    self  = [super init];
    if (self) {
        self.userName = [aDecoder decodeObjectForKey:kUserName];
        self.userId = [aDecoder decodeObjectForKey:kUserId];
    }
        return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userId forKey:kUserId];
    [aCoder encodeObject:self.userName forKey:kUserName];
}


@end
