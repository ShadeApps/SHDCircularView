//
//  SHDFunctions.m
//  SHDCircularView
//
//  Created by Сергей Грищёв on 18.07.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import "SHDFunctions.h"

@implementation SHDFunctions

+ (UIColor *) colorFromHex:(NSString*)stringColor{
	return [SHDFunctions colorFromHex:stringColor withAlpha:1.0f];
}

+ (UIColor *) colorFromHex:(NSString*) stringColor withAlpha:(float)alpha{

	//Several rules
	if ([stringColor isEqualToString:@"white"]) return [[UIColor whiteColor] colorWithAlphaComponent:alpha];
	if ([stringColor isEqualToString:@"black"]) return [[UIColor blackColor]  colorWithAlphaComponent:alpha];
	if ([stringColor isEqualToString:@"lightGray"]) return [[UIColor lightGrayColor]  colorWithAlphaComponent:alpha];
	if ([stringColor isEqualToString:@"gray"]) return [[UIColor grayColor] colorWithAlphaComponent:alpha];
	if ([stringColor isEqualToString:@"red"]) return [[UIColor redColor] colorWithAlphaComponent:alpha];
	if ([stringColor isEqualToString:@"green"]) return [[UIColor greenColor] colorWithAlphaComponent:alpha];
	if ([stringColor isEqualToString:@"blue"]) return [[UIColor blueColor] colorWithAlphaComponent:alpha];

	if (stringColor.length == 0) return [UIColor blackColor];
	if ([[stringColor substringToIndex:1] isEqualToString:@"#"] == YES) stringColor = [stringColor substringFromIndex:1];

	if ([stringColor length] != 6) return [UIColor blackColor];

	stringColor = [stringColor uppercaseString];

	float red = 0;
	float green = 0;
	float blue = 0;

	int i = 0;
	while (i < [stringColor length])
	{
		NSString * hexChar = [stringColor substringWithRange: NSMakeRange(i, 2)];
		int value = 0;
		sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);

		if (i == 0) red = value;
		if (i == 2) green = value;
		if (i == 4) blue = value;

		i+=2;
	}

	if (red < 0 || red > 255 || green < 0 || green > 255 || blue < 0 || blue > 255) return [UIColor blackColor];

	return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(UIColor *)fontColor andDefaultText:(NSString *)text{
	return [SHDFunctions labelWithFontName:fontName fontSize:fontSize fontColor:fontColor shadowOffset:CGSizeMake(0, 0) shadowColor:[UIColor blackColor] andDefaultText:text];
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

@end
