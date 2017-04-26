//
//  UITableView+ProtocolConfigure.h
//  链式数据
//
//  Created by kidstone on 2017/4/25.
//  Copyright © 2017年 caochengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewProtocolHelper.h"

@interface UITableView (ProtocolConfigure)

@property (nonatomic, copy) UITableViewProtocolHelper *helper;

- (void)configureHelper:(void(^)(UITableViewProtocolHelper *helper))configuration;

@end
