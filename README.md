# UITableViewHelper
tableview链式实现数据源跟代理
####  使用说明：
``` objc
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
        });
    }];
    ```
