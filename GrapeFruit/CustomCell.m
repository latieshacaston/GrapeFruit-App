//
//  CustomCell.m
//  GrapeFruit
//
//  Created by Siming Yuan on 1/16/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "CustomCell.h"
#import "CustomCellBackground.h"

@implementation CustomCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // change to our custom selected background view
        CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backgroundView;
    }
    return self;
}

@end
