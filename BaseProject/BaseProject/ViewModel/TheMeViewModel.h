//
//  TheMeViewModel.h
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TheMeModel.h"

@interface TheMeViewModel : BaseViewModel
/** 列表数组 */
@property (nonatomic,strong)NSArray *itemData;
/** 行数 */
@property (nonatomic,assign)NSInteger rowNumber;
/** 每行的标题 */
- (NSString *)titleForRow:(NSInteger)row;
/** 对应的标识 */
- (NSString *)URLIdForRow:(NSInteger)row;
@end
