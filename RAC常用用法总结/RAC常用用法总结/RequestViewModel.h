//
//  RequestViewModel.h
//  RAC常用用法总结
//
//  Created by Windy on 2018/4/2.
//  Copyright © 2018年 Windy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "AFNetworking.h"

@interface RequestViewModel : NSObject

@property(nonatomic, strong, readonly)RACCommand *requestCommand;

@end
