//
//  SHDCircularView.h
//  SHDCircularView
//
//  Created by Sergey Grischyov on 20.05.14.
//  Copyright (c) 2014 ShadeApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDCircularView : UIView <UIGestureRecognizerDelegate>

- (void)placeOuterArrayObjectsFromArray:(NSArray *)friendsArray;

- (void)placeInnerArrayObjectsFromArray:(NSArray *)innerFriendsArray;

@property (strong, nonatomic) NSMutableArray *friendObjectsArray;

@end
