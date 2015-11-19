//
//  TheMeViewModel.m
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TheMeViewModel.h"



@implementation TheMeViewModel

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    [XunJieNewsNetManager getTheMeListDatakcompletionHandle:^(TheMeListModel *model, NSError *error) {
        self.itemData = model.others;
        completionHandle(error);
    }];
}
- (TheMeListOthersModel *)modelForRow:(NSInteger)row
{
    return self.itemData[row];
}
-(NSInteger)rowNumber
{
    return self.itemData.count;
}
-(NSString *)titleForRow:(NSInteger)row
{
    return [self modelForRow:row].name;
}
-(NSString *)URLIdForRow:(NSInteger)row
{
    return [NSString stringWithFormat:@"%ld", [self modelForRow:row].aid];
}
@end
