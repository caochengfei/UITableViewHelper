//
//  ViewController.m
//  UITableViewHelper
//
//  Created by kidstone on 2017/4/26.
//  Copyright © 2017年 caochengfei. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+ProtocolConfigure.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)  NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"链式数据源";
    
    __weak __typeof(&*self)weakSelf = self;
    [weakSelf.tableview configureHelper:^   (UITableViewProtocolHelper *helper) {
        helper.bindTableView(weakSelf.tableview, [UITableViewCell class], NO, @"cell").heightForRow(^CGFloat(NSIndexPath *indexPath) {
            return 50;
        }).sectionsNumber(^NSInteger{
            return 1;
        }).rowsNumber(^NSInteger(NSInteger section) {
            return weakSelf.dataArray.count;
        }).configureCell(^(__kindof UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = weakSelf.dataArray[indexPath.row];
        }).didSelectCell(^(NSIndexPath *indexPath) {
            
            UITableViewCell *cell = [weakSelf.tableview cellForRowAtIndexPath:indexPath];
            
            NSTimeInterval duration = 0.6;
            CAKeyframeAnimation *springAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            springAnimation.values = @[@.85, @1.15, @.9, @1.0,];
            springAnimation.keyTimes = @[@(0.0 / duration), @(0.15 / duration) , @(0.3 / duration), @(0.45 / duration),];
            springAnimation.duration = duration;
            [cell.layer addAnimation:springAnimation forKey:@"SpringAnimationKey"];
            
        });
    }];

}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
        for (int i = 0; i < 100; i ++) {
            [_dataArray addObject:@"这是一个cell"];
        }
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
