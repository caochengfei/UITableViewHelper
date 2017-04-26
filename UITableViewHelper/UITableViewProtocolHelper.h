//
//  TableViewProtocolHelper.h
//  dajiaochong
//
//  Created by kidstone on 2017/4/25.
//  Copyright © 2017年 kidstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UITableViewProtocolHelper;

typedef UITableViewProtocolHelper* (^TVHeightForRow)(CGFloat(^)(NSIndexPath *indexPath));
typedef UITableViewProtocolHelper* (^TVNumberOfSections)(NSInteger(^)(void));
typedef UITableViewProtocolHelper* (^TVRowsNumberAtSection)(NSInteger(^)(NSInteger section));
typedef UITableViewProtocolHelper* (^TVDidSelectAtIndexPath)(void(^)(NSIndexPath *indexPath));
typedef UITableViewProtocolHelper* (^TVConfigureCell)(void(^)(__kindof UITableViewCell *cell, NSIndexPath *indexPath));
typedef UITableViewProtocolHelper* (^TVBindAndRegister)(UITableView *tableView, Class cellClass, BOOL isNib, NSString * reuseIdentifier);


@interface UITableViewProtocolHelper : NSObject<UITableViewDelegate,UITableViewDataSource>

/**
 绑定tableview
 */
@property (nonatomic, copy, readonly) TVBindAndRegister         bindTableView;

/**
 配置cell
 */
@property (nonatomic, copy, readonly) TVConfigureCell           configureCell;

/**
 对应numberOfSectionsInTableView
 */
@property (nonatomic, copy, readonly) TVNumberOfSections        sectionsNumber;

/**
 对应numberOfRowsInSection
 */
@property (nonatomic, copy, readonly) TVRowsNumberAtSection     rowsNumber;

/**
 对应numberOfRowsInSection
 */
@property (nonatomic, copy, readonly) TVDidSelectAtIndexPath    didSelectCell;

/**
 对应heightForRowAtIndexPath
 */
@property (nonatomic, copy, readonly) TVHeightForRow            heightForRow;



@end
