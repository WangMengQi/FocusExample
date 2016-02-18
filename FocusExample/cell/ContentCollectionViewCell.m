//
//  ContentCollectionViewCell.m
//  FangDai
//
//  Created by Miki on 16/2/17.
//  Copyright © 2016年 ylly. All rights reserved.
//

#import "ContentCollectionViewCell.h"
#import "ViewUtils.h"

CGFloat featuredHeight = 213.0;
CGFloat standardHegiht = 100.0;
CGFloat minAlpha = 0.1;
CGFloat maxAlpha = 0.45;

@implementation ContentCollectionViewCell


- (void)resize
{
    [self setWidth:[[UIScreen mainScreen] bounds].size.width];
    [_backImgView setWidth:self.width];
    [_overlayView setWidth:self.width];
    [_priceLabel setRight:self.width - 20.0];
    [_hahaLabel setLeft:20.0];
    [_lineLabel setLeft:20.0];
    [_smallLabel setLeft:20.0];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self resize];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    CGFloat delta = 1- (featuredHeight - CGRectGetHeight(self.frame)) / (featuredHeight - standardHegiht);
    
    CGFloat alpha = maxAlpha - (delta * (maxAlpha - minAlpha));

    
    _overlayView.alpha = alpha;
    
    _lineLabel.alpha = 1 - delta;
    _lineLabel.bottom = self.height - 15.0;
    _priceLabel.bottom = self.height - 15.0;
    _hahaLabel.bottom = self.height - 15.0;
    _hahaLabel.alpha = delta;
    
    _smallLabel.alpha = delta;
}

@end
