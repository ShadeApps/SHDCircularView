//
//  SHDFunctions.h
//  SHDCircularView
//
//  Created by Сергей Грищёв on 18.07.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHDFunctions : NSObject

+ (UIColor *) colorFromHex:(NSString*)stringColor;
+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(float)fontSize fontColor:(NSString *)fontColor andDefaultText:(NSString *)text;

@end
