//
//  TheMeDetailViewModel.h
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface TheMeDetailViewModel : BaseViewModel
/** 初始化方法 */
- (instancetype)initWithTypeId:(NSString *)typeId;
@property(nonatomic,strong)NSString *typeId;
/** 新闻名字 */
@property (nonatomic,strong)NSString *naviTitle;
/** 导航栏背景图片 */
@property (nonatomic,strong)NSURL *naviImageURL;
/** 页面数据数组 */
@property (nonatomic,strong)NSMutableArray *stories;
/** 页面行数 */
@property (nonatomic,assign)NSInteger rowNumber;
/** 单元格标题 */
- (NSString *)titleForRow:(NSInteger)row;
/** 单元格图片 */
- (NSURL *)imageURLForRow:(NSInteger)row;
/** 内容ID */
- (NSString *)IDForRow:(NSInteger)row;
/** 内容页id数组 */
@property (nonatomic,strong)NSMutableArray *storiesId;
@end
