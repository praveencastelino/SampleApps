/*
     File: InfiniteScrollView.m
 Abstract: This view tiles UILabel instances to give the effect of infinite scrolling side to side.
  Version: 1.2
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2013 Apple Inc. All Rights Reserved.
 
 */

#import "InfiniteScrollView.h"
#import "CustomView.h"

@interface InfiniteScrollView ()

@property (nonatomic, strong) NSMutableArray *visibleLabels;
@property (nonatomic, strong) CustomView *labelContainerView;
@end


@implementation InfiniteScrollView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        self.contentSize = CGSizeMake(2000, 2000);
        _visibleLabels = [[NSMutableArray alloc] init];
        
        _labelContainerView = [[CustomView alloc] init];
        self.labelContainerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
        
        [_labelContainerView setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.labelContainerView];

        [self.labelContainerView setUserInteractionEnabled:NO];
        [self setBackgroundColor:[UIColor greenColor]];
        // hide horizontal scroll indicator so our recentering trick is not revealed
        [self setShowsHorizontalScrollIndicator:YES];
        [self setBounces:NO];
    }
    return self;
}


#pragma mark - Layout

// recenter content periodically to achieve impression of infinite scrolling
- (void)recenterIfNecessary
{
    CGPoint currentOffset = [self contentOffset];
    CGFloat contentHeight = [self contentSize].height;
    //NSLog(@"%@ - %@",NSStringFromCGRect([self bounds]),NSStringFromCGPoint([self contentOffset]));
    
    CGFloat contentWidth = [self contentSize].width;

    CGPoint centerOffset,distanceFromCenter;
     centerOffset.y = (contentHeight - [self bounds].size.height) / 2.0;
    distanceFromCenter.y  = fabs(currentOffset.y - centerOffset.y);
    
    centerOffset.x = (contentWidth - [self bounds].size.width) / 2.0;
    distanceFromCenter.x  = fabs(currentOffset.x - centerOffset.x);

    if (distanceFromCenter.y > (contentHeight / 6.0))
    {
        self.contentOffset = CGPointMake(currentOffset.x, centerOffset.y);
        [_labelContainerView didResetByVerticalDistancePoint:CGPointMake(currentOffset.x, centerOffset.y - currentOffset.y) visibleFrame:[self bounds]];
    }
   
    
    if (distanceFromCenter.x > (contentWidth / 6.0))
    {
        self.contentOffset = CGPointMake(centerOffset.x, currentOffset.y);
        [_labelContainerView didResetByHorizontalDistancePoint: CGPointMake(centerOffset.x - currentOffset.x, currentOffset.y) visibleFrame:[self bounds]];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self recenterIfNecessary];
 
    [_labelContainerView process:[self bounds]];
}


@end
