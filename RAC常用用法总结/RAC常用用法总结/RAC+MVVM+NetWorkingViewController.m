//
//  RAC+MVVM+NetWorkingViewController.m
//  RAC常用用法总结
//
//  Created by Windy on 2018/4/2.
//  Copyright © 2018年 Windy. All rights reserved.
//

#import "RAC+MVVM+NetWorkingViewController.h"
#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"
#import "RequestViewModel.h"

@interface RAC_MVVM_NetWorkingViewController ()
// 请求视图模型
@property(nonatomic, strong)RequestViewModel *requestVM;

@end

@implementation RAC_MVVM_NetWorkingViewController

- (RequestViewModel *)requestVM {
    if (!_requestVM) {
        _requestVM = [[RequestViewModel alloc] init];
    }
    return _requestVM;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // GET  https://api.douban.com/v2/book/search
    
    // 发送请求
    RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}

@end
