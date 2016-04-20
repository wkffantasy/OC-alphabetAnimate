//
//  ViewController.m
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import "ViewController.h"

#import "MyCarGroupModel.h"
#import "MyCarModel.h"
#import "MyCarCell.h"

#import "MyCarsView.h"

//颜色
#define WKFColor(a,b,c,d) [UIColor colorWithRed:(a)/255. green:(b)/255. blue:(c)/255. alpha:(d)]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,MyCarsViewDelegate>

//存放数据的数组
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,weak)UITableView *tableView;

//自定义右侧view
@property (nonatomic,weak)MyCarsView *myView;


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
  tableView.showsVerticalScrollIndicator=NO;
  tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
  tableView.frame=CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
  _tableView=tableView;
  [self.view addSubview:tableView];
  
  
  //一个label
  UILabel *label = [[UILabel alloc]init];
  label.frame =CGRectMake(0, 20, self.view.frame.size.width, 80);
  label.text = @"滑动右侧的字母表\n有惊喜哦";
  label.textAlignment = NSTextAlignmentCenter;
  label.textColor = WKFColor(81, 81, 81, 1);
  label.numberOfLines=0;
  label.font = [UIFont systemFontOfSize:25];
  [self.view addSubview:label];
  
}

//创建右侧索引的view
-(void)setupRightIndexView{
  
  //数据的数组
  NSMutableArray *array = [NSMutableArray array];
  for (MyCarGroupModel *model in self.dataArray) {
    
    [array addObject:model.title];
  }
  
  //创建自定义的view
  MyCarsView *myView = [[MyCarsView alloc]init];
  myView.delegate=self;
  CGFloat w=50;
  CGFloat h=20*self.dataArray.count;
  CGFloat y=(self.tableView.frame.size.height-h)/2+CGRectGetMinY(self.tableView.frame);
  CGFloat x=self.view.frame.size.width-w;
  myView.frame=CGRectMake(x, y, w, h);
  myView.dataArray = array;
  _myView = myView;
  [self.view addSubview:myView];
  
  
}
#pragma mark - MyCarsViewDelegate代理方法
-(void)touchEndPoint:(CGPoint)point andWithSelectedTag:(int)tag{
  
  //滑动tableView 根据tag
  if (tag<0) {
    tag=0;
  }else if (tag>self.dataArray.count-1){
    tag=(int)self.dataArray.count-1;
  }
  
  NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:tag];
  [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
  
}


#pragma mark - UITableViewDataSource,,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  MyCarGroupModel *model =self.dataArray[section];
  return model.cars.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  MyCarCell *cell = [MyCarCell cellWithTableView:tableView];
  
  MyCarGroupModel *groupModel =self.dataArray[indexPath.section];
  MyCarModel *model =groupModel.cars[indexPath.row];
  cell.model=model;
  return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  MyCarGroupModel *model =self.dataArray[section];
  return model.title;
}

//懒加载
-(NSMutableArray *)dataArray{
  
  if (_dataArray ==nil) {
    
    _dataArray = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:path];
    for (NSDictionary *dict1 in array) {
      
      MyCarGroupModel *model = [MyCarGroupModel MyCarGroupModelWithDict:dict1];
      [_dataArray addObject:model];
     
    }
    
  }
  return _dataArray;
  
}

@end
