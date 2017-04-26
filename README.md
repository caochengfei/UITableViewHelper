# UITableViewHelper
tableview链式实现数据源跟代理
####  使用说明：
```
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
    ```
