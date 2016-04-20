//
//  ViewController.m
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import "ViewController.h"

//model
#import "MyCarGroupModel.h"
#import "MyCarModel.h"

//view
#import "MyCarCell.h"
#import "MyCarsView.h"

//lib
#import "Masonry.h"

//颜色
#define WKFColor(a,b,c,d) [UIColor colorWithRed:(a)/255. green:(b)/255. blue:(c)/255. alpha:(d)]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

//存放数据的数组
@property (strong,nonatomic) NSMutableArray * dataArray;

@property (weak,nonatomic) UITableView * tableView;

//自定义右侧view
@property (weak,nonatomic) MyCarsView * myView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
 
  self.view.backgroundColor = WKFColor(200, 200, 200, 1);
  
  //创建tableView
  [self setupTableView];
  
  //创建右侧索引的view
  [self setupRightIndexView];
  
}
//创建tableView
-(void)setupTableView{
  
  UITableView *tableView = [[UITableView alloc]init];
  tableView.backgroundColor = [UIColor whiteColor];
  tableView.delegate=self;
  tableView.dataSource=self;
  tableView.estimatedRowHeight = 50;
  tableView.rowHeight = UITableViewAutomaticDimension;
  
  tableView.sectionHeaderHeight = 30;
  tableView.showsVerticalScrollIndicator=NO;
  tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
  _tableView=tableView;
  [self.view addSubview:tableView];
  
  //一个label
  UILabel *label = [[UILabel alloc]init];
  label.text = @"滑动右侧的字母表\n有惊喜哦";
  label.textAlignment = NSTextAlignmentCenter;
  label.textColor = WKFColor(81, 81, 81, 1);
  label.numberOfLines=0;
  label.font = [UIFont systemFontOfSize:25];
  [self.view addSubview:label];
  
  [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.and.right.and.bottom.mas_equalTo(0);
    make.top.mas_equalTo(100);
  }];
  
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.and.left.mas_equalTo(0);
    make.top.mas_equalTo(20);
    make.bottom.mas_equalTo(_tableView.mas_top);
  }];
  
}

//创建右侧索引的view
-(void)setupRightIndexView{
  
  NSMutableArray *array = [NSMutableArray array];
  for (MyCarGroupModel *model in self.dataArray) {
    
    [array addObject:model.title];
    
  }
  
  CGFloat singleH = 20;
  
  __weak typeof(self)weakSelf = self;
  
  MyCarsView *myView = [[MyCarsView alloc]initWithDataArray:array withSinglLabelH:singleH andTouchEndBlock:^(int tag) {
    
    //touch end
    if (tag<0) {
      tag=0;
    }else if (tag>self.dataArray.count-1){
      tag=(int)self.dataArray.count-1;
    }
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:tag];
    [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
  }];

  _myView = myView;
  
  [self.view addSubview:myView];
  
  [_myView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.centerY.mas_equalTo(self.tableView.mas_centerY);
    make.right.mas_equalTo(0);
    make.width.mas_equalTo(50);
    make.height.mas_equalTo(singleH * self.dataArray.count);
    
  }];
  
}


#pragma mark - UITableViewDataSource,,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  NSAssert(self.dataArray.count >= 1, @"");
  return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  MyCarGroupModel *model =self.dataArray[section];
  return model.cars.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  MyCarCell *cell = [MyCarCell cellWithTableView:tableView];
  MyCarGroupModel *groupModel =self.dataArray[indexPath.section];
  MyCarModel *model =groupModel.cars[indexPath.row];
  cell.model=model;
  return cell;
  
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  
  MyCarGroupModel *model =self.dataArray[section];
  return model.title;
}

- (NSMutableArray *)dataArray{
  
  if (_dataArray ==nil) {
    
    _dataArray = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:path];
    
    NSAssert(array.count > 0, @"");
    
    for (NSDictionary *dict1 in array) {
      
      MyCarGroupModel *model = [MyCarGroupModel MyCarGroupModelWithDict:dict1];
      
      [_dataArray addObject:model];
     
    }
    
  }
  return _dataArray;
  
}

@end
