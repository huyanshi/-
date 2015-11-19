//
//  HomePageCell.m
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "HomePageCell.h"

@implementation HomePageCell

-(TRImageView *)iconIV
{
    if (!_iconIV) {
        _iconIV = [[TRImageView alloc]init];
    }
    return _iconIV;
}
-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.font = [UIFont boldSystemFontOfSize:16 ];
        _titleLb.numberOfLines = 0;
        
    }
    return _titleLb;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconIV];
        [self.contentView addSubview:self.titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
//            make.bottom.mas_equalTo(-15);
            
        }];
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            //150 120
            make.topMargin.mas_equalTo(self.titleLb.mas_topMargin);
            make.right.bottom.mas_equalTo(-15);
            make.left.mas_equalTo(self.titleLb.mas_right).mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(75, 60));
        }];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
