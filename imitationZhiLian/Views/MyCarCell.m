//
//  MyCarCell.m
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import "MyCarCell.h"

#import "Masonry.h"

//颜色
#define WKFColor(a,b,c,d) [UIColor colorWithRed:(a)/255. green:(b)/255. blue:(c)/255. alpha:(d)]

#define iconWH  40

@interface MyCarCell ()

//图片
@property (nonatomic,weak)UIImageView *iconView;

//名称
@property (nonatomic,weak)UILabel *nameLabel;

//分割线
@property (nonatomic,weak)UIView *sepView;

@end

@implementation MyCarCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
  
  static NSString *cellID = @"MyCarCell";
  MyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  if (cell == nil) {
    cell = [[MyCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  return cell;
  
}

- (void)setModel:(MyCarModel *)model{
  
  _model = model;
  
  self.iconView.image = [UIImage imageNamed:_model.icon];
  self.nameLabel.text =_model.name;
  
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  
    [self setupChildViews];
    
  }
  return self;
  
}

- (void)setupChildViews{
  
  UIImageView *iconView = [[UIImageView alloc]init];
  _iconView = iconView;
  [self.contentView addSubview:iconView];
  
  UILabel *nameLabel = [[UILabel alloc]init];
  nameLabel.textAlignment = NSTextAlignmentLeft;
  _nameLabel = nameLabel;
  [self.contentView addSubview:nameLabel];
  
  UIView *sepView = [[UIView alloc]init];
  sepView.backgroundColor = WKFColor(200, 200, 200, 1);
  _sepView = sepView;
  [self.contentView addSubview:sepView];
  
  //layoutSubviews
  [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.top.mas_equalTo(5);
    make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
    make.centerY.mas_equalTo(self.contentView.mas_centerY);
    make.width.and.height.mas_equalTo(iconWH);
    make.left.mas_equalTo(20);
    
  }];
  
  [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.centerY.mas_equalTo(self.contentView.mas_centerY);
    make.left.mas_equalTo(self.iconView.mas_right).offset(20);
    
  }];
  
  [_sepView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.bottom.and.right.mas_equalTo(0);
    make.height.mas_equalTo(0);
    make.left.mas_equalTo(_nameLabel.mas_left);
    
  }];
  
  
}

@end
