//
//  UITableView+ProtocolConfigure.m
//  链式数据
//
//  Created by kidstone on 2017/4/25.
//  Copyright © 2017年 caochengfei. All rights reserved.
//

#import "UITableView+ProtocolConfigure.h"
#import <objc/runtime.h>

static const char * HELPERKEY = "TableViewProtocolHelperKey";

@implementation UITableView (ProtocolConfigure)

- (void)configureHelper:(void(^)(UITableViewProtocolHelper *helper))configuration {
    UITableViewProtocolHelper *helper = [UITableViewProtocolHelper new];
    configuration(helper);
    self.helper = helper;
    self.delegate = helper;
    self.dataSource = helper;
}

- (void)setHelper:(UITableViewProtocolHelper *)Helper{
    objc_setAssociatedObject(self, HELPERKEY, Helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITableViewProtocolHelper *)helper {
    return objc_getAssociatedObject(self, HELPERKEY);
}


@end
