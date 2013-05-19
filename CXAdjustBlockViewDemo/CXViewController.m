//
//  CXViewController.m
//  CXAdjustBlockViewDemo
//
//  Created by ChrisXu on 13/5/8.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import "CXViewController.h"
#import "CXBlockScrollView.h"

@interface CXViewController ()
{
    NSMutableArray *blockViews;
    
    CXBlockScrollView *scrollview;
    
    UILabel *lastLabel;
}

- (IBAction)addTenPixel:(id)sender;

@end

@implementation CXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    blockViews = [[NSMutableArray alloc] init];
    
    scrollview = [[CXBlockScrollView alloc] initWithFrame:CGRectMake(0, 0, 240, 300)];
    [scrollview setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:scrollview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)addTenPixel:(id)sender
{
    switch ([sender tag])
    {
        case 0:
        {
            UILabel *demoLabel = [[UILabel alloc] initWithFrame:CGRectMake( 20, 0, 200, 30)];
            [demoLabel setFont:[UIFont boldSystemFontOfSize:18.f]];
            [demoLabel setTextColor:[UIColor darkGrayColor]];
            [demoLabel setTextAlignment:NSTextAlignmentLeft];
            [demoLabel setBackgroundColor:[UIColor clearColor]];
            [demoLabel setText:[NSString stringWithFormat:@"No. %i block view",[blockViews count]]];
            [scrollview addBlockview:demoLabel withSpacing:10];
            
            [blockViews addObject:demoLabel];
            break;
        }
        case 1:
        {
            NSInteger random = arc4random() % ([blockViews count] - 1);
            UILabel *demoLabel1 = [blockViews objectAtIndex:random];
            [demoLabel1 setFrame:CGRectMake(10, 0, 200, 50)];
            lastLabel = demoLabel1;
            break;
        }
        case 2:
        {
            if (lastLabel)
            {
                [lastLabel setFrame:CGRectMake( 20, 0, 200, 30)];
            }
            break;
        }
        default:
            break;
    }
}
@end
