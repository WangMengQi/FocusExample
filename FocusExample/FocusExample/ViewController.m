//
//  ViewController.m
//  HanabiExample
//
//  Created by Miki on 16/2/18.
//  Copyright © 2016年 ylly. All rights reserved.
//

#import "ViewController.h"
#import "ContentCollectionViewCell.h"
#import "FocusCollectionViewLayout.h"

@interface ViewController ()
{
    FocusCollectionViewLayout *_hanabiCollectionViewLayout;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _hanabiCollectionViewLayout = [[FocusCollectionViewLayout alloc]init];
    [_hanabiCollectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [_hanabiCollectionViewLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen]bounds].size.height) collectionViewLayout:_hanabiCollectionViewLayout];
    [_collectionView registerNib:[UINib nibWithNibName:@"ContentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    cell.backImgView.image = [self imageAtIndex:indexPath.item];
    return cell;
}


- (UIImage *)imageAtIndex:(NSInteger)index
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"background-%li.jpg",(index + 1)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
