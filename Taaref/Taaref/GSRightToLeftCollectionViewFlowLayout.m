//
//  GSRightToLeftCollectionViewFlowLayout.m
//  Taaref
//
//  Created by Bader Alrasheed on 9/24/14.
//  Copyright (c) 2014 Baims. All rights reserved.
//

#import "GSRightToLeftCollectionViewFlowLayout.h"

typedef enum {
    // enum for comfortibility.
    CellXPositionLeft = 1,
    CellXpositionRight = 2,
    CellXpositionCenter = 3,
    CellXPositionNone = 4
} CellXPosition;

@interface GSRightToLeftCollectionViewFlowLayout ()

@property (nonatomic) BOOL cellFlag;
@property (nonatomic) float cellLeftX;
@property (nonatomic) float cellMiddleX;
@property (nonatomic) float cellRightX;

@end

@implementation GSRightToLeftCollectionViewFlowLayout

// when ever the bounds change, call layoutAttributesForElementsInRect:
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allItems = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    for (UICollectionViewLayoutAttributes *attribute in allItems) {
        
        // when we get an item, calculate it's English writing position,
        // so that we can convert it to the Hebrew - Arabic position.
        if (!self.cellFlag) {
            
            [self calculateLocationsForCellsWithAttribute:attribute];
            
            self.cellFlag = YES;
        }
        
        // if it's a header, do not change it's place.
        if (attribute.representedElementKind == UICollectionElementKindSectionHeader) {
            
            continue;
        }
        
        // check where the item should be placed.
        CellXPosition position = [self attributeForPosition:attribute];
        
        switch (position) {
            case CellXPositionLeft:
                attribute.frame = CGRectMake(self.cellLeftX, attribute.frame.origin.y, attribute.frame.size.width, attribute.frame.size.height);
                break;
            case CellXpositionRight:
                attribute.frame = CGRectMake(self.cellRightX, attribute.frame.origin.y, attribute.frame.size.width, attribute.frame.size.height);
                break;
            case CellXpositionCenter:
                attribute.frame = CGRectMake(self.cellMiddleX, attribute.frame.origin.y, attribute.frame.size.width, attribute.frame.size.height);
                break;
            case CellXPositionNone:
                NSLog(@"warning");
                break;
        }
    }
    
    return allItems;
}


- (CellXPosition)attributeForPosition:(UICollectionViewLayoutAttributes *)attribute
{
    CellXPosition cellXposition = CellXPositionNone;
    
    // we will return an opposite answer
    if (attribute.indexPath.row % 3 == 0) {
        
        // if it's in the left side, move it to the right
        cellXposition = CellXpositionRight;
        
    } else if (attribute.indexPath.row % 3 == 1) {
        
        cellXposition = CellXpositionCenter;
        
    } else if (attribute.indexPath.row % 3) {
        
        // if it's in the right side, move it to the left
        cellXposition = CellXPositionLeft;
    }
    
    return cellXposition;
}

- (void)calculateLocationsForCellsWithAttribute:(UICollectionViewLayoutAttributes *)attribute
{
    float cellWidth = self.itemSize.width;
    float minimumX = self.sectionInset.left;
    float maximumX = self.sectionInset.right;
    float displayWidth = self.collectionView.contentSize.width - minimumX - maximumX;
    // on iOS6, displayWidth will be 0 (don't know why), so insert an if (displayWidth == 0) and set manually the size.
    
    self.cellLeftX = minimumX;
    float space = (displayWidth - cellWidth * 3) / 2;
    self.cellMiddleX = self.cellRightX + cellWidth + space;
    self.cellRightX = self.cellMiddleX + cellWidth + space;
}

@end
