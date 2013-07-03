//
//  CXAdjustBlockView.h
//  CXAdjustBlockViewDemo
//
//  Created by ChrisXu on 13/5/8.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CXAdjustBlockViewUpdated @"CXAdjustBlockViewUpdated"

@protocol CXAdjustBlockViewDelegate;

@interface CXAdjustBlockView : UIView
@property (nonatomic, assign) id<CXAdjustBlockViewDelegate> delegate;
@property (nonatomic) NSUInteger bvID;
@property (nonatomic) CGFloat spacing;
@property (nonatomic) NSTimeInterval duration;

- (id)initWithLinstenerView:(CXAdjustBlockView *)view;

- (void)updateLayoutWithDelegate:(BOOL)need;

- (void)setLinstener:(CXAdjustBlockView *)view;

@end

@protocol CXAdjustBlockViewDelegate <NSObject>

@optional
- (void)blockViewDidUpdateFrameWithBVID:(NSUInteger)bvID;

@end;