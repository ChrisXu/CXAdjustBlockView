//
//  CXBlockScrollView.h
//  CXAdjustBlockViewDemo
//
//  Created by ChrisXu on 13/5/8.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXAdjustBlockView;

@protocol CXBlockScrollViewDelegate;

@interface CXBlockScrollView : UIScrollView
@property (nonatomic, assign) id<CXBlockScrollViewDelegate> blocksDelegate;
@property (nonatomic) NSUInteger numbersOfBlockviews;

- (void)addBlockview:(UIView *)view withSpacing:(NSUInteger)spacing;
- (void)insertBlockview:(UIView *)view atIndex:(NSUInteger)index withSpacing:(NSUInteger)spacing;
- (void)removeBlockview:(UIView *)view;
- (CGRect)frameOfBlockview:(UIView *)view;

@end

@protocol CXBlockScrollViewDelegate <NSObject>

@optional
- (void)blockScrollView:(CXBlockScrollView *)scrollview contentSizeDidChangedWithSize:(CGSize)size;
- (void)blockScrollView:(CXBlockScrollView *)scrollview didAnimatedAtIndex:(NSUInteger)index frame:(CGRect)frame;

@end
