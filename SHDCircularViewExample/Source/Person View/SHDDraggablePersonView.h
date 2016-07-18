//
//  SHDDraggablePersonView.h
//  SHDCircularView
//
//  Created by Grischyov Sergey on 21.05.14.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHDPerson.h"

@interface SHDDraggablePersonView : UIView

@property (strong, nonatomic) UIImageView *personImageView;
@property (strong, nonatomic) UILabel *personNameLabel;
@property (strong, nonatomic) SHDPerson *currentObject;

@property (nonatomic) CGRect originalViewRect;

@end