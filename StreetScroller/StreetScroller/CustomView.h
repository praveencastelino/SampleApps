//
//  CustomView.h
//  StreetScroller
//
//  Created by praveen castelino on 15/05/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

-(void)didResetByVerticalDistancePoint:(CGPoint)distance visibleFrame:(CGRect)frame;
-(void)didResetByHorizontalDistancePoint:(CGPoint)distance visibleFrame:(CGRect)frame;

-(void)process:(CGRect)frame;

@end
