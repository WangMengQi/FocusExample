//
//  ViewController.h
//  HanabiExample
//
//  Created by Miki on 16/2/18.
//  Copyright © 2016年 ylly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}



@end

