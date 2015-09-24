//
//  ViewController.m
//  FirstProjectInGit
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ViewController.h"
//#import <objc/objc.h>
//#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic, strong) UITableView *baseTable;
@property (nonatomic, strong) NSArray *menuArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Demo Menu";
    [self.view setBackgroundColor:[UIColor redColor]];
    _menuArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"referanceViewController" ofType:@"plist"]];
    
    _baseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_baseTable setDelegate:(id<UITableViewDelegate>)self];
    [_baseTable setDataSource:(id<UITableViewDataSource>)self];
    [self.view addSubview:_baseTable];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MenuCell = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuCell];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MenuCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *menuDic = [self.menuArray objectAtIndex:indexPath.row];
    cell.textLabel.text = menuDic[@"title"];
    
    return cell;
}

#pragma mark --UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *menuDic = [self.menuArray objectAtIndex:indexPath.row];
    NSString *className = menuDic[@"vcName"];
    Class newClass = NSClassFromString(className);
    [self.navigationController pushViewController:[[newClass alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
