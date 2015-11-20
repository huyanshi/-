//
//  StoryViewModel.h
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface StoryViewModel : BaseViewModel
/** 初始化方法 */
- (instancetype)initWithStoryId:(NSString *)storyId;
@property (nonatomic,strong)NSString *storyId;
/** 返回URL */
- (NSURL *)storyURL;
/** 模型 */
@property (nonatomic,strong)StoryModel *storyModel;
/** 返回HTML内容 */
- (NSString *)storyHTML;
/** 返回头部图片 */
- (NSURL *)storyImageURL;
/** 返回头部文字 */
- (NSString *)storyImageTitleName;
/** 返回头部图片表示 */
- (NSString *)storyImageSource;
/** 判断是有body */
@property (nonatomic)BOOL hasBody;

@end
