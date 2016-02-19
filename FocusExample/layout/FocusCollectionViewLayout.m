//
//  HanabiCollectionViewLayout.m
//  FangDai
//
//  Created by Miki on 16/2/16.
//  Copyright © 2016年 ylly. All rights reserved.
//

#import "FocusCollectionViewLayout.h"

CGFloat defaultStandartHeight = 100.0;
CGFloat defaultFocusedHeight = 213;
CGFloat defaultDragOffset = 180.0;

@interface FocusCollectionViewLayout()
{
    NSArray *cachedLayoutAttributes;
}

@end

@implementation FocusCollectionViewLayout

- (id)init
{
    self = [super init];
    if (self) {
        cachedLayoutAttributes = [[NSArray alloc]init];
        _standartHeight = defaultStandartHeight;
        _focusedHeight = defaultFocusedHeight;
        _dragOffset = defaultDragOffset;
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    NSInteger itemsCount = [self numberOfItems];
    CGFloat contentHeight = (itemsCount) * _dragOffset + ([self height] - _dragOffset);
    return CGSizeMake([self width], contentHeight);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat proposedItemIndex = roundf(proposedContentOffset.y / _dragOffset);
    CGFloat nearestPageOffset = proposedItemIndex * _dragOffset;
    
    return CGPointMake(0.0, nearestPageOffset);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [[NSMutableArray alloc]init];
    for (UICollectionViewLayoutAttributes *attributes in cachedLayoutAttributes) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
    }
    return layoutAttributes;
}

- (void)prepareLayout
{
    NSMutableArray *cache = [[NSMutableArray alloc]init];
    NSInteger itemsCount = [self numberOfItems];
    CGRect frame = CGRectZero;
    CGFloat y = 0.0;
    
    for (NSInteger item = 0; item < itemsCount; item ++ ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        CGFloat height = _standartHeight;
        NSInteger currentFocusedIndex = [self currentFocusedItemIndex];
        CGFloat nextItemOffset = [self nextItemPercentageOffset:currentFocusedIndex];
        if (indexPath.item == currentFocusedIndex) {
            y = [self yOffset] - _standartHeight*nextItemOffset;
            height = _focusedHeight;
        }
        else if (indexPath.item == (currentFocusedIndex + 1) && indexPath.item != itemsCount)
        {
            height = _standartHeight + MAX((_focusedHeight - _standartHeight) * nextItemOffset, 0);
            CGFloat maxYOffset = y + _standartHeight;
            y = maxYOffset - height;
        }
        else
        {
            y = frame.origin.y + frame.size.height;
        }
        
        frame = CGRectMake(0, y, [self width], height);
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.zIndex = item;
        attributes.frame = frame;
        
        [cache addObject:attributes];
        
        y = CGRectGetMaxY(frame);
    }
    cachedLayoutAttributes = cache;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return cachedLayoutAttributes[indexPath.item];
}

- (NSInteger)currentFocusedItemIndex
{
    NSInteger index = [self yOffset] / _dragOffset;
    return MAX(0, index);
}

- (CGFloat)nextItemPercentageOffset:(NSInteger)index
{
    return ([self yOffset] / _dragOffset) - index;
}

- (NSInteger)numberOfItems
{
    return [self.collectionView numberOfItemsInSection:0];
}

- (CGFloat)width
{
    return CGRectGetWidth(self.collectionView.frame);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.collectionView.frame);
}

- (CGFloat)yOffset
{
    return self.collectionView.contentOffset.y;
}

- (void)setStandartHeight:(CGFloat)standartHeight
{
    if (standartHeight) {
        _standartHeight = standartHeight;
    }
}

@end
