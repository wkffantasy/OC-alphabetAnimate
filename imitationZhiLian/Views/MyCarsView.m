//
//  MyCarsView.m
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import "MyCarsView.h"

//view
#import "MyLabel.h"

//lib
#import "Masonry.h"

//颜色
#define WKFColor(a,b,c,d) [UIColor colorWithRed:(a)/255. green:(b)/255. blue:(c)/255. alpha:(d)]

//时间
#define time 0.3

@interface MyCarsView ()

@property (assign,nonatomic)CGFloat singleLabelH;

@property (assign,nonatomic)int selectTag;

@property (strong,nonatomic)NSArray *dataArray;

@property (copy, nonatomic) TouchEndSelectedTagBlock touchEnd;

@end

@implementation MyCarsView

- (instancetype)initWithDataArray:(NSArray *)dataArray withSinglLabelH:(CGFloat)singleH andTouchEndBlock:(TouchEndSelectedTagBlock)touchEndBlock{
  
  if (self = [super init]) {
    
    NSAssert(dataArray.count > 0, @"");
    NSAssert(singleH > 0, @"");
    
    _singleLabelH = singleH;
    _dataArray = dataArray;
    _selectTag = -1;
    _touchEnd  = touchEndBlock;
    [self setupViews];
  }
  return self;
  
}

- (void)setupViews{
  
  for (int i = 0; i<_dataArray.count; i++) {
    
    MyLabel *titleLabel = [[MyLabel alloc]init];
    titleLabel.text = _dataArray[i];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = WKFColor(123, 123, 123, 1);
    titleLabel.tag=i;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
      make.height.mas_equalTo(_singleLabelH);
      make.top.mas_equalTo(i * _singleLabelH);
      make.right.and.left.mas_equalTo(0);
      
    }];

  }
  
}

//触摸开始
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  UITouch *touch = [touches anyObject];
  CGPoint beganPoint = [touch locationInView:self];
  
  int tag=beganPoint.y/self.singleLabelH;
  
  [self makeBeganMove:tag andPoint:beganPoint];
  
}
//触摸滑动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  UITouch *touch = [touches anyObject];
  CGPoint touchMove = [touch locationInView:self];
  
  int tag=touchMove.y/self.singleLabelH;
  
  [self makeMove:tag andPoint:touchMove];
  
}
//触摸停止
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  UITouch *touch = [touches anyObject];
  CGPoint touchEnd = [touch locationInView:self];
  
  int tag = touchEnd.y/self.singleLabelH;
  [self makeEndMove:tag andPoint:touchEnd];

}

//触摸开始的时候的动画
- (void)makeBeganMove:(int)tag andPoint:(CGPoint)point{

  for (MyLabel *label in self.subviews) {
    
    //中间的那个
    if (label.tag==tag) {
      
      [self makeLabelMove:label andToValue:-40 andFromValue:label.fromValue];
      
    }
    
    //上边的四个或者少于四个
    if (label.tag>=tag-4 && label.tag>=0 && label.tag<tag) {
      int toValue =(int)-(4-(tag-label.tag))*10 ;
      [self makeLabelMove:label andToValue:toValue andFromValue:label.fromValue];
      
    }
    //下边的四个或者少于四个
    if (label.tag<self.dataArray.count && label.tag<=tag+4 && label.tag>tag) {
    
      [self makeLabelMove:label andToValue:(int)-(4-(-tag+label.tag))*10 andFromValue:label.fromValue];
      
    }
    
  }
  
}

//触摸的时候的动画
- (void)makeMove:(int)tag andPoint:(CGPoint)point{
  
  if (tag==self.selectTag) {
    return;
  }
  self.selectTag = tag;
  
  //其余的
  for (MyLabel *label in self.subviews) {
    
    NSAssert(label.tag >= 0, @"");;
    NSAssert(label.tag<self.dataArray.count,@"");
    //最在上面几个 或者没有 回归原位
    if (tag-4>label.tag) {
      
       [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];

    }
    //上边的四个或者少于四个
    else if (label.tag>=tag-4 && label.tag<tag) {
      
      [self makeLabelMove:label andToValue:(int)-(4-(tag-label.tag))*10 andFromValue:label.fromValue];
      
    }
    //中间的那个
    else if (label.tag==tag) {
      
      [self makeLabelMove:label andToValue:-40 andFromValue:label.fromValue];
      
    }
    //下边的
    else if (label.tag<tag+4 && label.tag>tag) {
      
      [self makeLabelMove:label andToValue:(int)-(4-(-tag+label.tag))*10 andFromValue:label.fromValue];

    }
    //最下面的几个 或者没有 回归原位 条件是//(label.tag>tag+4)
     else {
       
       [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];
      
      }
  }
}

//触摸结束的时候的动画
- (void)makeEndMove:(int)tag andPoint:(CGPoint)point{
  
  if (self.touchEnd) {
    
    self.touchEnd(tag);
    
  }
  //所有的回归原位
  for (MyLabel *label in self.subviews) {
    
    [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];
    
  }
  
}

- (void)makeLabelMove:(MyLabel *)label andToValue:(int)toValue andFromValue:(int)fromValue{
  
  CABasicAnimation *anim = [CABasicAnimation animation];
  anim.duration=time;
  anim.removedOnCompletion = NO;
  anim.fillMode = kCAFillModeForwards;
  anim.keyPath = @"transform.translation.x";
  anim.fromValue = @(fromValue);
  anim.toValue = @(toValue);
  label.fromValue=toValue;
  [label.layer addAnimation:anim forKey:nil];
  
  //改变颜色
  int colorMultiple = -toValue/10;
  
  if (colorMultiple!=4) {
    int colorAdd = colorMultiple * 35 + 123;
    label.textColor = WKFColor(colorAdd, colorAdd, colorAdd,1);
    
  }else {
  
    label.textColor = WKFColor(0, 0, 0, 1);//黑色
  }
  
  
}



@end
