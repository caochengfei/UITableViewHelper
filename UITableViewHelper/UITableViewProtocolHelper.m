//
//  TableViewProtocolHelper.m
//  dajiaochong
//
//  Created by kidstone on 2017/4/25.
//  Copyright © 2017年 kidstone. All rights reserved.
//

#import "UITableViewProtocolHelper.h"

typedef CGFloat(^heightForRowAtIndexPath)(NSIndexPath *indexPath);
typedef NSInteger(^numberOfSection)(void);
typedef NSInteger(^numberOfRowsInSection)(NSInteger section);
typedef void(^didSelectAtIndexPath)(NSIndexPath *indexPath);
typedef void(^cellForRowAtIndexPath)(__kindof UITableViewCell *cell, NSIndexPath *indexPath);

@interface UITableViewProtocolHelper ()

@property (nonatomic, copy) numberOfSection         numberOfSection;
@property (nonatomic, copy) numberOfRowsInSection   numberOfrowsInSection;
@property (nonatomic, copy) didSelectAtIndexPath    didSelectAtIndexPath;
@property (nonatomic, copy) cellForRowAtIndexPath   cellForRowAtIndexPath;
@property (nonatomic, copy) heightForRowAtIndexPath heightForRowAtIndexPath;
@property (nonatomic, copy) NSString                *reuseIdentifier;

@end

@implementation UITableViewProtocolHelper

- (TVBindAndRegister)bindTableView {
    return ^UITableViewProtocolHelper* (UITableView *tableView, __unsafe_unretained Class cellClass, BOOL isNib, NSString *reuseIdentifier) {
        tableView.delegate      = self;
        tableView.dataSource    = self;
        self.reuseIdentifier = reuseIdentifier;
        if (isNib) {
            NSString *nibName = NSStringFromClass(cellClass);
            UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
        } else {
            [tableView registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
        }
        
        return self;
    };
    
}

- (TVHeightForRow)heightForRow {
    return ^UITableViewProtocolHelper* (CGFloat(^heightForRowAtIndexPath)(NSIndexPath *indexPath)) {
        self.heightForRowAtIndexPath = heightForRowAtIndexPath;
        return self;
    };
}

- (TVRowsNumberAtSection)rowsNumber {
    return ^UITableViewProtocolHelper* (NSInteger(^numberOfRowsInSection)(NSInteger section)) {
        
        self.numberOfrowsInSection = numberOfRowsInSection;
        return self;
    };
}

- (TVNumberOfSections)sectionsNumber {
    return ^UITableViewProtocolHelper* (NSInteger(^numberOfSection)(void)){
        self.numberOfSection = numberOfSection;
        return self;
    };
}

- (TVDidSelectAtIndexPath)didSelectCell{
    return ^UITableViewProtocolHelper* (void(^didSelectAtIndexPath)(NSIndexPath *indexPath)) {
        self.didSelectAtIndexPath = didSelectAtIndexPath;
        return self;
    };
}

- (TVConfigureCell)configureCell {
    return ^UITableViewProtocolHelper* (void(^cellForRowAtIndexPath)(__kindof UITableViewCell *cell, NSIndexPath *indexPath)){
        self.cellForRowAtIndexPath = cellForRowAtIndexPath;
        return self;
    };
}


#pragma mark -- TableViewDelegate andTableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.heightForRowAtIndexPath(indexPath);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSection();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfrowsInSection(section);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier ];
    }
    self.cellForRowAtIndexPath(cell, indexPath);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.didSelectAtIndexPath(indexPath);
}



@end
