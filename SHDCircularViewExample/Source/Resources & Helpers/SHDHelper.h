//
//  SHDFunctions.h
//  SHDCircularView
//
//  Created by Сергей Грищёв on 18.07.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHDHelper : NSObject

#pragma mark - Fast UI Helpers

+ (void)removeMembersOfClass:(Class)aClass fromSubviewsOfView:(UIView *)view;
+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(UIColor *)fontColor andDefaultText:(NSString *)text;

#pragma mark - Calculation helpers

+ (float)distanceFromCenter:(CGPoint)centerPoint forPoint:(CGPoint)evaluatedPoint;

@end
