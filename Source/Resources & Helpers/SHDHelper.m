//
//  SHDFunctions.m
//  SHDCircularView
//
//  Created by Сергей Грищёв on 18.07.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "SHDHelper.h"

@implementation SHDHelper

#pragma mark - Fast UI Helpers

+ (void)removeMembersOfClass:(Class)aClass fromSubviewsOfView:(UIView *)view{
	for (id object in view.subviews) {
		if ([object isKindOfClass:[aClass class]]){
			[object removeFromSuperview];
		}
	}
}

+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(UIColor *)fontColor andDefaultText:(NSString *)text{
	return [SHDHelper labelWithFontName:fontName fontSize:fontSize fontColor:fontColor shadowOffset:CGSizeMake(0, 0) shadowColor:[UIColor blackColor] andDefaultText:text];
}

+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(UIColor *)fontColor shadowOffset:(CGSize)shadowOffset shadowColor:(UIColor *)shadowColor andDefaultText:(NSString *)text{
	UILabel *tmpLabel = [[UILabel alloc] init];
	[tmpLabel setBackgroundColor:[UIColor clearColor]];
	tmpLabel.font = [UIFont fontWithName:fontName size:fontSize];
	tmpLabel.textColor = fontColor;

	if (!CGSizeEqualToSize(shadowOffset, CGSizeZero)){
		tmpLabel.shadowColor = shadowColor;
		tmpLabel.shadowOffset = shadowOffset;
	}

	tmpLabel.text = text;
	[tmpLabel sizeToFit];
	return tmpLabel;
}

#pragma mark - Calculation helpers

+ (float)distanceFromCenter:(CGPoint)centerPoint forPoint:(CGPoint)evaluatedPoint{
	CGFloat dx = centerPoint.x - evaluatedPoint.x;
	CGFloat dy = centerPoint.y - evaluatedPoint.y;
	return sqrt(dx*dx + dy*dy);
}

@end