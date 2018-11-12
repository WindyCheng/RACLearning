//
//  RAC+MVVMViewController.m
//  RAC常用用法总结
//
//  Created by Windy on 2018/4/2.
//  Copyright © 2018年 Windy. All rights reserved.
//

#import "RAC+MVVMViewController.h"
#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"
#import "loginViewModel.h"

@interface RAC_MVVMViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic, strong) loginViewModel *loginVM;

@end

@implementation RAC_MVVMViewController

- (loginViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[loginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    // MVVM:
    // VM:视图模型----处理展示的业务逻辑
    // 每一个控制器都对应一个VM模型
    
    
    
    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[self.accountField.rac_textSignal, self.pwdField.rac_textSignal] reduce:^id(NSString *account, NSString *pwd){
        return @(account.length && pwd.length);
    }];
    // 设置按钮是否能点击
    RAC(self.loginBtn, enabled) = loginEnableSignal;
    
    // 创建登录命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block调用：执行命令就会调用
        // block作用：事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                // 发送数据
                [subscriber sendNext:@"发送登录的数据"];
                [subscriber sendCompleted]; // 一定要记得写
            });
            
            return nil;
        }];
    }];
    // 获取命令中的信号源
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 监听命令执行过程
    [[command.executing skip:1] subscribeNext:^(id x) { // 跳过第一步（没有执行这步）
        if ([x boolValue] == YES) {
            NSLog(@"--正在执行");
            // 显示蒙版
        }else { //执行完成
            NSLog(@"执行完成");
            // 取消蒙版
        }
    }];
    
    // 监听登录按钮点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击登录按钮");
        // 处理登录事件
        [command execute:nil];
        
    }];
    
}



@end
