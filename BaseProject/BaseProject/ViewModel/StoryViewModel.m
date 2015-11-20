//
//  StoryViewModel.m
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "StoryViewModel.h"

@implementation StoryViewModel
- (instancetype)initWithStoryId:(NSString *)storyId
{
    if (self = [super init]) {
        self.storyId = storyId;
    }
    return self;
}
//获取数据
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [XunJieNewsNetManager getStoryDataWithID:_storyId completionHandle:^(StoryModel *model, NSError *error) {
        self.storyModel = model;
        completionHandle(error);
    }];
}
-(NSURL *)storyURL
{
    return [NSURL URLWithString:self.storyModel.share_url];
}
-(NSURL *)storyImageURL
{
    return [NSURL URLWithString:self.storyModel.image];
}
/** 返回头部文字 */
- (NSString *)storyImageTitleName
{
    return self.storyModel.title;
}
/** 返回头部图片来源 */
- (NSString *)storyImageSource
{
    return [NSString stringWithFormat:@"图片：%@",self.storyModel.image_source];
}
-(BOOL)hasBody
{
    return self.storyModel.body?YES:NO;
}
- (NSString *)storyHTML
{
    /**
     *  
     var html = "<html>"
     html += "<head>"
     html += "<link rel=\"stylesheet\" href="
     html += css
     html += "</head>"
     html += "<body>"
     html += body
     html += "</body>"
     html += "</html>
     */
    NSString *html =[NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@</head><body>%@</body></html>",self.storyModel.css.firstObject,self.storyModel.body];
    return html;
}
@end
