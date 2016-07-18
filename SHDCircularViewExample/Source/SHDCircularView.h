//
//  SHDCircularView.h
//  SHDCircularView
//
//  Created by Sergey Grischyov on 20.05.14.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularConstants.h"
#import "SHDPerson.h"

@interface SHDCircularView : UIView <UIGestureRecognizerDelegate>

@property (strong, nonatomic, readonly) NSMutableArray *friendObjectsArray;

- (void)placeOuterCircleObjects:(NSArray *)friendsArray;

- (void)placeInnerCircleObjects:(NSArray *)innerFriendsArray;

@end