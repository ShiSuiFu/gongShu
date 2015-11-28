//
//  NSString+additional.h
//  daShu
//
//  Created by 史岁富 on 15/11/3.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (additional)
- (NSString *)md5;
- (BOOL)isPureInt;//是否是int
-(NSAttributedString *)selfFont:(int)sfont
                      selfColor:(UIColor *)selfColor
                      LightText:(NSString *)text
                      LightFont:(int)lfont
                     LightColor:(UIColor *)lightColor;
- (NSString*)trim1;
+ (NSString *)getDate:(NSString *)TimeInterval;
+ (NSString *)stringWithGetCurrentTime;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
- (BOOL)isContainsSubStr:(NSString *)subStr;
+ (NSString *)getDate1:(NSString *)TimeInterval;
+ (CGFloat)heightForText:(NSString *)text withWidth:(CGFloat)width WithFont:(CGFloat)font;
+ (CGFloat)widthForText:(NSString *)text withWheight:(CGFloat)height WithFont:(CGFloat)font;
@end
