//
//  CustomCellBackgroud.m
//  TestCollectionView
//
//  Created by Siming Yuan on 1/16/16.
//  Copyright © 2016 Siming Yuan. All rights reserved.
//

#import "CustomCellBackground.h"

@implementation CustomCellBackground


- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointZero radius:50.0 startAngle:0 endAngle:2* M_PI clockwise:NO];
    bezierPath.lineWidth = 5.0;
    //[[UIColor blackColor] setStroke];
    //[bezierPath stroke];
    
    CGContextRestoreGState(aRef);
    
}


@end
