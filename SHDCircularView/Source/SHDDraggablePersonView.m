//
//  SHDDraggablePersonView.m
//  SHDCircularView
//
//  Created by Grischyov Sergey on 21.05.14.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import "SHDDraggablePersonView.h"
#import "SHDFunctions.h"
#import "CircularConstants.h"

@implementation SHDDraggablePersonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __basicInit];
    }
    return self;
}

- (void)__basicInit{
	_personImageView = [[UIImageView alloc] initWithImage:[UIImage new]];
    _personImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _personImageView.clipsToBounds = YES;
    _personImageView.layer.cornerRadius = _personImageView.frame.size.width / 2;
    _personImageView.layer.borderWidth = 1.0;
    _personImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:_personImageView];
    
    _personImageView.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    _personNameLabel = [SHDFunctions labelWithFontName:@"HelveticaNeue-Light" fontSize:10 fontColor:[UIColor whiteColor] andDefaultText:@"Laura"];
    _personNameLabel.frame = CGRectMake(0, floorf(self.frame.size.height + _personNameLabel.frame.size.height - 8), self.frame.size.width, _personNameLabel.frame.size.height);
    _personNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_personNameLabel];
    
    _originalViewRect = self.frame;
}

@end