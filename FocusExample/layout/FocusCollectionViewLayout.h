//
//  HanabiCollectionViewLayout.h
//  FangDai
//
//  Created by Miki on 16/2/16.
//  Copyright © 2016年 ylly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat standartHeight;
@property (nonatomic, assign) CGFloat focusedHeight;
@property (nonatomic, assign) CGFloat dragOffset;

- (void)setStandartHeight:(CGFloat)standartHeight;

@end
