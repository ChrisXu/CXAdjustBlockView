//
//  CXBlockScrollView.m
//  CXAdjustBlockViewDemo
//
//  Created by ChrisXu on 13/5/8.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import "CXBlockScrollView.h"
#import "CXAdjustBlockView.h"

@interface CXBlockScrollView ()
<CXAdjustBlockViewDelegate>
{
    NSInteger bvTotalCount;
    NSMutableArray *blockViews;
}

- (void)lastBlockviewDidFinishUpdated:(NSNotification *)notify;
- (void)updateContentSize;

@end

@implementation CXBlockScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        blockViews = [[NSMutableArray alloc] init];
        bvTotalCount = 0;
    }
    return self;
}

#pragma mark - PV
- (void)lastBlockviewDidFinishUpdated:(NSNotification *)notify
{
    if ([notify object] == [blockViews lastObject])
    {
        [self updateContentSize];
    }
}

- (void)updateContentSize
{
    CXAdjustBlockView *lastBlockView = [blockViews lastObject];
    CGFloat height = 0;
    height = CGRectGetMaxY(lastBlockView.frame);
    [self setContentSize:CGSizeMake(self.bounds.size.width, height)];
    if (_blocksDelegate && [_blocksDelegate respondsToSelector:@selector(blockScrollView:contentSizeDidChangedWithSize:)])
    {
        [_blocksDelegate blockScrollView:self contentSizeDidChangedWithSize:CGSizeMake(self.bounds.size.width, height)];
    }
}

#pragma mark - PB
- (void)addBlockview:(UIView *)view withSpacing:(NSUInteger)spacing;
{
    CXAdjustBlockView *lastBlockView = [blockViews lastObject];
    CXAdjustBlockView *blockView = [[CXAdjustBlockView alloc] initWithLinstenerView:lastBlockView];
    blockView.bvID = bvTotalCount;
    blockView.spacing = spacing;
    blockView.delegate = self;
    
    bvTotalCount ++;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CXAdjustBlockViewUpdated object:lastBlockView];
    
    CGFloat offsetY = lastBlockView == nil ? 0 : CGRectGetMaxY(lastBlockView.frame);
    [blockView setFrame:CGRectMake( 0, offsetY, self.bounds.size.width, view.frame.size.height + spacing)];
    CGRect replaceFrame = CGRectZero;
    replaceFrame.origin = CGPointMake(view.frame.origin.x, 0);
    replaceFrame.size   = view.frame.size;
    [view setFrame:replaceFrame];
    
    [blockView addSubview:view];
    [blockView setBackgroundColor:[UIColor clearColor]];
    
    [blockViews addObject:blockView];
    [self addSubview:blockView];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lastBlockviewDidFinishUpdated:) name:CXAdjustBlockViewUpdated object:blockView];
}

- (void)insertBlockview:(UIView *)view atIndex:(NSUInteger)index withSpacing:(NSUInteger)spacing
{
    NSInteger blockViewsCount = [blockViews count];
    if (blockViewsCount == 0 || index > blockViewsCount - 1)
    {
        [self addBlockview:view withSpacing:spacing];
        return;
    }
    
    CXAdjustBlockView *previousBlockView = index > 0 ? [blockViews objectAtIndex:index - 1] : nil;
    CXAdjustBlockView *blockView = nil;
    CXAdjustBlockView *nextBlockView = [blockViews objectAtIndex:index];

    blockView = [[CXAdjustBlockView alloc] initWithLinstenerView:previousBlockView];
    blockView.bvID = bvTotalCount;
    blockView.spacing = spacing;
    blockView.delegate = self;
    bvTotalCount ++;
    
    CGFloat offsetY = previousBlockView == nil ? 0 : CGRectGetMaxY(previousBlockView.frame);
    [blockView setFrame:CGRectMake( 0, offsetY, self.bounds.size.width, view.frame.size.height + spacing)];
    CGRect replaceFrame = CGRectZero;
    replaceFrame.origin = CGPointMake(view.frame.origin.x, 0);
    replaceFrame.size   = view.frame.size;
    [view setFrame:replaceFrame];
    
    [blockView addSubview:view];
    [blockView setBackgroundColor:[UIColor clearColor]];
    
    [nextBlockView setLinstener:blockView];
    
    [blockViews insertObject:blockView atIndex:index];
    [self insertSubview:blockView belowSubview:nextBlockView];
    
    if (previousBlockView)
    {
        [previousBlockView updateLayoutWithDelegate:NO];
    }
    else
    {
        [UIView animateWithDuration:nextBlockView.duration animations:^{
            [nextBlockView setFrame:CGRectMake( 0, 0, self.bounds.size.width, nextBlockView.frame.size.height)];
        }];
        [nextBlockView updateLayoutWithDelegate:YES];
    }
}

- (void)removeBlockview:(UIView *)view
{
    NSInteger blockViewsCount = [blockViews count];
    CXAdjustBlockView *previousBlockView = nil;
    CXAdjustBlockView *currentBlockView = nil;
    CXAdjustBlockView *nextBlockView = nil;
    BOOL _exist = NO;
    
    for (int i = 0 ; i < blockViewsCount; i++)
    {
        currentBlockView = [blockViews objectAtIndex:i];
        for (UIView *targetView in [currentBlockView subviews])
        {
            if ([targetView isEqual:view])
            {
                _exist = YES;
                if (i != 0)
                {
                    previousBlockView = [blockViews objectAtIndex:(i - 1)];
                }
                
                if (i != (blockViewsCount - 1))
                {
                    nextBlockView = [blockViews objectAtIndex:(i + 1)];
                    [nextBlockView setLinstener:previousBlockView];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:CXAdjustBlockViewUpdated object:currentBlockView];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lastBlockviewDidFinishUpdated:) name:CXAdjustBlockViewUpdated object:previousBlockView];
                }
                
                break;
            }
        }
        
        if (_exist)
        {
            break;
        }
    }
    [currentBlockView setDelegate:nil];
    [currentBlockView removeFromSuperview];
    [blockViews removeObject:currentBlockView];
    
    if (previousBlockView)
    {
        [previousBlockView updateLayoutWithDelegate:NO];
    }
    else
    {
        [UIView animateWithDuration:nextBlockView.duration animations:^{
            [nextBlockView setFrame:CGRectMake( 0, 0, self.bounds.size.width, nextBlockView.frame.size.height)];
        }];
        [nextBlockView updateLayoutWithDelegate:YES];
    }
}

- (CGRect)frameOfBlockview:(UIView *)view
{
    NSInteger blockViewsCount = [blockViews count];
    CXAdjustBlockView *currentBlockView = nil;
    for (int i = 0 ; i < blockViewsCount; i++)
    {
        currentBlockView = [blockViews objectAtIndex:i];
        for (UIView *targetView in [currentBlockView subviews])
        {
            if ([targetView isEqual:view])
            {
                return currentBlockView.frame;
            }
        }
    }
    
    return CGRectZero;
}

#pragma mark - CXAdjustBlockViewDelegate
- (void)blockViewDidUpdateFrameWithBVID:(NSUInteger)bvID
{
    if (_blocksDelegate && [_blocksDelegate respondsToSelector:@selector(blockScrollView:didAnimatedAtIndex:frame:)])
    {
        NSInteger blockViewsCount = [blockViews count];
        for (int index = 0; index < blockViewsCount; index ++)
        {
            CXAdjustBlockView *blockview = [blockViews objectAtIndex:index];
            if (blockview.bvID == bvID)
            {
                [_blocksDelegate blockScrollView:self didAnimatedAtIndex:index frame:blockview.frame];
                break;
            }
        }
    }
}

@end
