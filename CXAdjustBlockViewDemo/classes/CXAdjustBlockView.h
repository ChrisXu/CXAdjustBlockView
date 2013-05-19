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
@property (nonatomic) CGFloat space;
@property (nonatomic) NSTimeInterval duration;
- (id)initWithLinstenerView:(UIView *)view;

- (void)updateLayout;
@end
