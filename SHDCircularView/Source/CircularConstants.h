//
//  CircularConstants.h
//  SHDCircularView
//
//  Created by Сергей Грищёв on 18.07.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#ifndef CircularConstants_h
#define CircularConstants_h

#define MAIN_TINT_COLOR [UIColor colorWithRed:0.329 green:0.733 blue:0.847 alpha:1.00]
#define MAIN_TINT_COLOR_DARK [UIColor colorWithRed:0.245 green:0.552 blue:0.638 alpha:1.00]
#define MAIN_BACKGROUND_COLOR [UIColor colorWithRed:0.125 green:0.125 blue:0.125 alpha:1.00]

static const CGFloat kUserCenterAvatarRadius = 58;

//Outer Circle

static const CGFloat kOuterCircleRatioDifference = 40;

static const int kMaxOuterPeopleCount = 8;

static const CGFloat kOuterCirlceLayerWidth = 45;

// Inner Circle

static const int kInitialInnerPeopleCount = 8;

static const CGFloat kInnerCirlceViewRadius = 168;

static const CGFloat kInnerCirlceLayerWidth = 34;

static const CGFloat kInnerCircleRatioDifference = 58;

#endif /* CircularConstants_h */
