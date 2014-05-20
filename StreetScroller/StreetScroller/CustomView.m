//
//  CustomView.m
//  StreetScroller
//
//  Created by praveen castelino on 15/05/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "CustomView.h"

#define HEIGHT 200
#define SPACING 50
#define ITEMS 30

@interface CustomView ()

@property(nonatomic) CGFloat contentOffsetY;
@property(nonatomic) CGFloat contentOffsetX;


@end

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _contentOffsetY = 0;
        _contentOffsetX = 0;
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGFloat width = HEIGHT;
    CGFloat height = HEIGHT;
    
    CGFloat yPos = _contentOffsetY;
    CGFloat xPos = _contentOffsetX;
    CGFloat verticalSpacing = SPACING;
    CGFloat horizontalSpacing = SPACING;


    for(int i = 0; i < ITEMS; i++)
    {
        for (int j = 0; j < ITEMS; j++) {
            CGRect r = CGRectMake(xPos, yPos, width, height);
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:r];
            [[UIColor blueColor] set];
            [path fill];
            xPos = xPos + width + horizontalSpacing;
            [[UIColor whiteColor] set];

            [[NSString stringWithFormat:@"(%d,%d)",i,j] drawInRect:r withFont:[UIFont boldSystemFontOfSize:40]];
        }
        yPos = yPos + height + verticalSpacing;
        xPos = _contentOffsetX;
    }
    
}


-(void)didResetByVerticalDistancePoint:(CGPoint)distance visibleFrame:(CGRect)frame
{
    _contentOffsetY += distance.y;
    NSLog(@"_contentOffsetY %f",_contentOffsetY);
    [self setNeedsDisplay];
}


-(void)didResetByHorizontalDistancePoint:(CGPoint)distance visibleFrame:(CGRect)frame
{
    _contentOffsetX += distance.x;
    NSLog(@"_contentOffsetX %f",_contentOffsetX);
    [self setNeedsDisplay];
}

-(void)process:(CGRect)frame
{
//    NSLog(@"%@",NSStringFromCGRect(frame));

}


@end
