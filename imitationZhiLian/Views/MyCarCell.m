//
//  MyCarCell.m
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import "MyCarCell.h"

//颜色
#define WKFColor(a,b,c,d) [UIColor colorWithRed:(a)/255. green:(b)/255. blue:(c)/255. alpha:(d)]

@interface MyCarCell ()

//图片
@property (nonatomic,weak)UIImageView *iconView;

//名称
@property (nonatomic,weak)UILabel *nameLabel;

//分割线
@property (nonatomic,weak)UIView *sepView;

@end

@implementation MyCarCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
  
  static NSString *cellID = @"MyCarCell";
  MyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  if (cell == nil) {
    cell = [[MyCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  return cell;
  
}

-(void)setModel:(MyCarModel *)model{
  
  _model = model;
  
  self.iconView.image = [UIImage imageNamed:_model.icon];
  self.nameLabel.text =_model.name;
  
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //创建子控件
    [self setupChildViews];
    
  }
  return self;
  
}
//创建子控件
-(void)setupChildViews{
  
  UIImageView *iconView = [[UIImageView alloc]init];
  _iconView = iconView;
  [self addSubview:iconView];
  
  UILabel *nameLabel = [[UILabel alloc]init];
  nameLabel.textAlignment = NSTextAlignmentLeft;
  _nameLabel = nameLabel;
  [self addSubview:nameLabel];
  
  UIView *sepView = [[UIView alloc]init];
  sepView.backgroundColor = WKFColor(200, 200, 200, 1);
  _sepView = sepView;
  [self addSubview:sepView];
  
  
}
-(void)layoutSubviews{
  
  [super layoutSubviews];
  
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  
  CGFloat iconWH =40;
  CGFloat iconY  =(self.frame.size.height-iconWH)/2;
  CGFloat iconX  =20;
  _iconView.frame=CGRectMake(iconX, iconY, iconWH, iconWH);
  
  _nameLabel.frame=CGRectMake(CGRectGetMaxX(_iconView.frame)+20, 0, 200, self.frame.size.height);
  
  _sepView.frame=CGRectMake(CGRectGetMaxX(_iconView.frame)+20, self.frame.size.height-0.5,width-CGRectGetMaxX(_iconView.frame)-20-20, 0.5);
  
  
}

@end
