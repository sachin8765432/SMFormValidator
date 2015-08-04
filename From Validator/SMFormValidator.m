//
//  FormValidator.m
//
//
//  Created by Sachin Mittal on 23/09/14.
//  Copyright (c) 2014 Sachin. All rights reserved.
//

#import "FormValidator.h"

@implementation FormValidator



+(BOOL) textFieldIsNotEmpty:(UITextField *)textField{
    BOOL valido;
    if ([textField.text isKindOfClass:[NSString class]] &&[textField.text length]==0) {
        valido = false;
    }else{
        valido = true;
    }
    return valido;
}

//This function will validate an email format
+(BOOL) NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

//This function validates a string with only numbers
+(BOOL) NSStringIsValidNumber:(NSString *)checkString{
    NSString *numberRegex = @"^(0|[1-9][0-9]*)$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:checkString];
}

//This function validates a string that contains only alphabetic values
+(BOOL) NSStringIsValidAlphabetValue:(NSString *)checkString{
    NSString *alphabetRegex = @"^([ \\u00c0-\\u01ffa-zA-Z'])+$";
    NSPredicate *alphabetTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphabetRegex];
    return [alphabetTest evaluateWithObject:checkString];
}

//This function validates a string as a valid phone number
+(BOOL) NSStringIsValidPhoneNumber:(NSString *)checkString{
    NSString *phoneNumberRegex = @"(([2-9]{1})([0-9]{2})([0-9]{3})([0-9]{4}))$";
    NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumberRegex];
    return [phoneNumberTest evaluateWithObject:checkString];
}

/*  This function validates a string as a valid password
 A password must have one Capital Letter, one Number and it's length at least 6 characters
 */
+(BOOL) NSStringIsValidPassword: (NSString *)checkString{
    //    NSString *passwordRegex = @"^([a-zA-Z0-9@*#]{8,15})$";
    //    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    //    return [passwordTest evaluateWithObject:checkString];
    return YES;
}

+ (BOOL)NSIntegerIsEmpty:(NSInteger *)checkInteger{
    if (checkInteger != 0) {
        return false;
    }
    return true;
}

//Este método verifica cuales campos no estan vacios y regresa un arreglo para identificar dichos campos
+ (NSMutableArray*)validateEmptyFieldsinForm:(NSArray *)fields{
    NSMutableArray *notEmptyFields;
    for (UITextField *tf in fields) {
        if ([self textFieldIsNotEmpty:tf]) {
            [notEmptyFields addObject:tf.text];
        }else{
            [notEmptyFields addObject:false];
        }
    }
    return notEmptyFields;
}

+ (NSMutableArray *)validateForm:(NSArray *)fields withRules:(NSArray *)valRules andErrorMessage:(NSString *)errorMessage{
    NSMutableArray *validatedInputs = [[NSMutableArray alloc]init];
    for (int i=0; i<[fields count]; i++) {
        if(![[fields objectAtIndex:i]isEqualToString:errorMessage]){
            //Check if the value in the field requires alphabetic validation
            if ([[valRules objectAtIndex:i]isEqualToString:@"alphabet"]) {
                [validatedInputs addObject:[NSNumber numberWithBool:[self NSStringIsValidAlphabetValue:[fields objectAtIndex:i]]]];
            }
            //Check if the value in the field requires numeric validation
            if ([[valRules objectAtIndex:i]isEqualToString:@"numeric"]) {
                [validatedInputs addObject:[NSNumber numberWithBool:[self NSStringIsValidNumber:[fields objectAtIndex:i]]]];
            }
            //Check if the value in the field requires email validation
            if ([[valRules objectAtIndex:i]isEqualToString:@"email"]) {
                [validatedInputs addObject:[NSNumber numberWithBool:[self NSStringIsValidEmail:[fields objectAtIndex:i]]]];
            }
            //Check if the value in the field requires password validation
            if ([[valRules objectAtIndex:i]isEqualToString:@"password"]) {
                [validatedInputs addObject:[NSNumber numberWithBool:[self NSStringIsValidPassword:[fields objectAtIndex:i]]]];
            }
            //Check if the value in the field requires phone number validation
            if ([[valRules objectAtIndex:i]isEqualToString:@"phone"]) {
                [validatedInputs addObject:[NSNumber numberWithBool:[self NSStringIsValidPhoneNumber:[fields objectAtIndex:i]]]];
            }
        }
    }
    return validatedInputs;
}

@end
