//
//  CustomCollectionViewController.m
//  FirstProjectInGit
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "CustomCollectionCell.h"

const NSInteger columCount = 2;

@interface CustomCollectionViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionArray;
@end

@implementation CustomCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _collectionArray = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"collectionData" ofType:@"plist"]];
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    [self.collectionView setDelegate:(id<UICollectionViewDelegateFlowLayout>)self];
    [self.collectionView setDataSource:(id<UICollectionViewDataSource>)self];
    [self.collectionView registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableCell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark --UICollectionViewCellDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCollectionViewCell = @"CustomCollectionViewCell";
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CustomCollectionViewCell forIndexPath:indexPath];
    [cell sizeToFit];
    if (nil == cell) {
        NSLog(@"自定义的cell还进入这里么？？？");
    }
    
    NSDictionary *dataDic = [self.collectionArray objectAtIndex:indexPath.row];
    [cell setData:dataDic];
    return cell;
}

#pragma mark --UICollectionViewCellDelegate
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (collectionView.frame.size.width-20)/columCount -5;
    CGFloat height = arc4random()%150  +80;
    return CGSizeMake(width, height);
}

//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
