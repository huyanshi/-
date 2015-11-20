//
//  StoryViewController.h
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryViewController : UIViewController
- (instancetype)initWithStoryId:(NSString *)storyId;
@property (nonatomic,strong)NSString *storyId;
/** 内容也数组 */
@property (nonatomic,strong)NSArray *storyNews;
/** 当前的新闻 */
@property (nonatomic)NSInteger index;
@end
