//
//  ViewController.m
//  XMLDataParse
//
//  Created by Civet on 2019/5/24.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "UserInfo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _arrayData = [[NSMutableArray alloc] init];
    [self parseXML];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayData.count;
}
- (void)parseXML{
    //获取解析文件的全路径
    //txt格式，内容为XML格式
    NSString *path = [[NSBundle mainBundle] pathForResource:@"filePath" ofType:@"txt"];
    //将XML读入到内存中，并与二进制方式存储
    NSData *dataXML = [NSData dataWithContentsOfFile:path];
    //创建XML文档对象
    //P1:XML格式的二进制对象
    //P2:选择性参数，默认为0
    NSError *error = nil;
    GDataXMLDocument *docXML = [[GDataXMLDocument alloc]initWithData:dataXML options:0 error:&error];
    NSLog(@"error = %@",error);
    //获取根节点元素对象
    GDataXMLElement *elemRoot = [docXML rootElement];
    //搜索节点下面的所有count元素对象
    //将所有根节点所有的count对象添加到数组中返回这个数组
    NSArray *arrCount = [elemRoot elementsForName:@"count"];
    GDataXMLElement *elemCount = [arrCount objectAtIndex:0];
    //获取具体的元素值
    NSString *strCount = [elemCount stringValue];
    NSLog(@"strCount = %@",strCount);
    
    NSArray *arrUList = [elemRoot elementsForName:@"user_list"];
    //获取最后一个元素
    GDataXMLElement *elemUList = [arrUList lastObject];
    NSArray *arrUsers = [elemUList elementsForName:@"user"];
    for (int i = 0; i < arrUList.count; i++){
        GDataXMLElement *elemUser = arrUsers[i];
        
        NSArray *arrUName = [elemRoot elementsForName:@"username"];
        //获取最后一个元素
        GDataXMLElement *elemUName = [arrUName lastObject];
        NSString *uName = [elemUName stringValue];
        
        NSArray *arrUID = [elemUser elementsForName:@"uid"];
        GDataXMLElement *elemUID = [arrUID lastObject];
        
        NSString *uID = [elemUID stringValue];
        NSLog(@"uName = %@",uName);
        NSLog(@"uID = %@",uID);
        UserInfo *uInfo = [[UserInfo alloc] init];
        uInfo.mUserName = uName;
        uInfo.mUserID = uID;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"ID";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    UserInfo *uInfo = [_arrayData objectAtIndex:indexPath.row];
    cell.textLabel.text = uInfo.mUserName;
    cell.detailTextLabel.text = uInfo.mUserID;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
