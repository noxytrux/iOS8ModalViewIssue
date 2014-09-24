//
//  NSLocale+LocalizedCountryCodes.h
//  ModalViewLabs
//
//  Created by Marcin Pędzimąż on 24.09.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocale (LocalizedCountryCodes)

+ (NSDictionary *)localizedNamesWithCodesDictionary;
+ (NSString *)localizedNameForCode:(NSString *)code;

@end
