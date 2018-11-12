//
//  loginViewModel2.h
//  RAC常用用法总结
//
//  Created by Windy on 2018/4/2.
//  Copyright © 2018年 Windy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface loginViewModel2 : NSObject

// 处理按钮是否允许点击
@property(nonatomic, strong, readonly) RACSignal *loginEnableSignal;
/**
 *  保存登录界面的账号和密码
 */
@property(nonatomic, strong) NSString *account;
@property(nonatomic, strong) NSString *pwd;
// 登录按钮的命令
@property(nonatomic, strong, readonly) RACCommand *loginCommand;

@end
