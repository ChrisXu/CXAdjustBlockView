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
@property (nonatomic) NSUInteger numbersOfBlockviews;

- (void)addBlockview:(UIView *)view withSpacing:(NSUInteger)spacing;
- (void)removeBlockview:(UIView *)view;
- (CGRect)frameOfBlockvie:(UIView *)view;

@end

@protocol CXBlockScrollViewDelegate <NSObject>


@end
