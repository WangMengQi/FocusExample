//
//  HanabiCollectionViewLayout.m
//  FangDai
//
//  Created by Miki on 16/2/16.
//  Copyright © 2016年 ylly. All rights reserved.
//

#import "FocusCollectionViewLayout.h"

CGFloat standartHeight = 100.0;
CGFloat focusedHeight = 213;
CGFloat dragOffset = 180.0;

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
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    NSInteger itemsCount = [self numberOfItems];
    CGFloat contentHeight = (itemsCount) * dragOffset + ([self height] - dragOffset);
    return CGSizeMake([self width], contentHeight);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat proposedItemIndex = roundf(proposedContentOffset.y / dragOffset);
    CGFloat nearestPageOffset = proposedItemIndex * dragOffset;
    
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
        CGFloat height = standartHeight;
        NSInteger currentFocusedIndex = [self currentFocusedItemIndex];
        CGFloat nextItemOffset = [self nextItemPercentageOffset:currentFocusedIndex];
        if (indexPath.item == currentFocusedIndex) {
            y = [self yOffset] - standartHeight*nextItemOffset;
            height = focusedHeight;
        }
        else if (indexPath.item == (currentFocusedIndex + 1) && indexPath.item != itemsCount)
        {
            height = standartHeight + MAX((focusedHeight - standartHeight) * nextItemOffset, 0);
            CGFloat maxYOffset = y + standartHeight;
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
    NSInteger index = [self yOffset] / dragOffset;
    return MAX(0, index);
}

- (CGFloat)nextItemPercentageOffset:(NSInteger)index
{
    return ([self yOffset] / dragOffset) - index;
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

@end
