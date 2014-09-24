//
//  NSLocale+LocalizedCountryCodes.m
//  ModalViewLabs
//
//  Created by Marcin Pędzimąż on 24.09.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

#import "NSLocale+LocalizedCountryCodes.h"

@implementation NSLocale (LocalizedCountryCodes)

+ (NSDictionary *)ISO3166_1_3Dictionary
{
    static NSDictionary *ISO3166_1_3Dictionary = nil;
    
    if (!ISO3166_1_3Dictionary) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countryCodeList" ofType:@"plist"];
        ISO3166_1_3Dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    
    return ISO3166_1_3Dictionary;
}

+ (NSDictionary *)localizedNamesWithCodesDictionary
{
    static NSMutableDictionary *countries = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        NSArray *countryCodes = [NSLocale ISOCountryCodes];
        
        NSDictionary *ISO639_2Codes = [[self class] ISO3166_1_3Dictionary];
        
        countries = [NSMutableDictionary dictionaryWithCapacity:[countryCodes count]];
        
        
        for (NSString *countryCode in countryCodes) {
            
            NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: countryCode forKey: NSLocaleCountryCode]];
            NSString *country = [[NSLocale currentLocale] displayNameForKey: NSLocaleIdentifier value: identifier];
            
            NSString *ISO3166_1_3CountryCode = ISO639_2Codes[countryCode];
            countries[ISO3166_1_3CountryCode] = country;
        }
        
    });
    
    return countries;
}

+ (NSString *)localizedNameForCode:(NSString *)code
{
    if (code == nil) {
        return nil;
    }
    
    return [self localizedNamesWithCodesDictionary ][code];
}

@end
