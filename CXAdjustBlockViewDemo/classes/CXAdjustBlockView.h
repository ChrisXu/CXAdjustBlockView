//
//  CXAdjustBlockView.h
//  CXAdjustBlockViewDemo
//
//  Created by ChrisXu on 13/5/8.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CXAdjustBlockViewUpdated @"CXAdjustBlockViewUpdated"

@interface CXAdjustBlockView : UIView
@property (nonatomic) NSInteger bvID;
@property (nonatomic) CGFloat spacing;
@property (nonatomic) NSTimeInterval duration;

- (id)initWithLinstenerView:(CXAdjustBlockView *)view;

- (void)updateLayout;

- (void)setLinstener:(CXAdjustBlockView *)view;

@end
