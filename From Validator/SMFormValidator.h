//
//  FormValidator.h
//
//
//  Created by Sachin Mittal on 23/09/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FormValidator : NSObject

+ (BOOL) textFieldIsNotEmpty:(UITextField *)textField;
+ (BOOL) NSStringIsValidEmail:(NSString *)checkString;
+ (BOOL) NSStringIsValidNumber:(NSString *)checkString;
+ (BOOL) NSStringIsValidAlphabetValue:(NSString *)checkString;
+ (BOOL) NSStringIsValidPhoneNumber:(NSString *)checkString;
+ (BOOL) NSStringIsValidPassword: (NSString *)checkString;
+ (BOOL) NSIntegerIsEmpty: (NSInteger *)checkInteger;

+ (NSMutableArray*)validateEmptyFieldsinForm:(NSArray *)fields;
+ (NSMutableArray *) validateForm:(NSArray *)fields withRules:(NSArray *)valRules andErrorMessage:(NSString *)errorMessage;
@end
