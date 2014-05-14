//
//  DKUserDictionary.m
//  DKUserDictionarySample
//
//  Created by daisuke on 2014/03/11.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//



#import "DKUserDictionary.h"



static DKUserDictionary *sObject;



@implementation DKUserDictionary {
    
    NSMutableDictionary *_cacheDictionary;
    
}



/*!
 
 @override NSObject
 
 */
- (id)init
{
    if (self = [super init]) {
        
        _cacheDictionary = self.dictionaryRepresentation.mutableCopy;
        
    }
    
    return self;
}



- (id)objectForKeyedSubscript:(id)key
{
    return _cacheDictionary[key]?: [super objectForKey:key];
}



- (void)setObject:(id)object
forKeyedSubscript:(id<NSCopying>)key
{
    [self setObject:object
             forKey:(NSString *)key];
    
    [self doSynchronize];
}



/*!
 
 do synchronize by autoSynchronize flag.
 
 */
- (void)doSynchronize
{
    if (_autoSynchronize) {
        [super synchronize];
    }
}



#pragma mark NSUserDefaults

/*!
 
 @overrides NSUserDefatuls
 
 cahge value in _cacheDictoinary.
 do synchronize by autoSynchronize flag.
 
 */
- (id)objectForKey:(NSString *)defaultName
{
    return _cacheDictionary[defaultName]?: [super objectForKey:defaultName];
}

- (void)setObject:(id)value
           forKey:(NSString *)defaultName
{
    // URL set by setURL:forKey:.
    if ([value isKindOfClass:NSURL.class]) {
        [super setURL:(NSURL *)value
               forKey:defaultName];
    }
    else {
        [super setObject:value
                  forKey:defaultName];
    }
    
    if (value) {
        _cacheDictionary[defaultName] = value;
    }
    else {
        [_cacheDictionary removeObjectForKey:defaultName];
    }
    
    [self doSynchronize];
}



- (NSString *)stringForKey:(NSString *)defaultName
{
    return (NSString *)_cacheDictionary[defaultName]?: [super stringForKey:defaultName];
}



- (NSArray *)arrayForKey:(NSString *)defaultName
{
    return (NSArray *)_cacheDictionary[defaultName]?: [super arrayForKey:defaultName];
}



- (NSDictionary *)dictionaryForKey:(NSString *)defaultName
{
    return (NSDictionary *)_cacheDictionary[defaultName]?: [super dictionaryForKey:defaultName];
}



- (NSData *)dataForKey:(NSString *)defaultName
{
    return (NSData *)_cacheDictionary[defaultName]?: [super dataForKey:defaultName];
}



//- (NSArray *)stringArrayForKey:(NSString *)defaultName{};



- (NSInteger)integerForKey:(NSString *)defaultName
{
    NSInteger ret;
    if (_cacheDictionary[defaultName]) {
        ret = ((NSNumber *)_cacheDictionary[defaultName]).integerValue;
    }
    else {
        ret = [super integerForKey:defaultName];
    }
    
    return ret;
}

- (void)setInteger:(NSInteger)value
            forKey:(NSString *)defaultName
{
    [super setInteger:value
               forKey:defaultName];
    _cacheDictionary[defaultName] = @(value);
    [self doSynchronize];
}



- (float)floatForKey:(NSString *)defaultName
{
    float ret;
    if (_cacheDictionary[defaultName]) {
        ret = ((NSNumber *)_cacheDictionary[defaultName]).floatValue;
    }
    else {
        ret = [super integerForKey:defaultName];
    }
    
    return ret;
}

- (void)setFloat:(float)value
          forKey:(NSString *)defaultName
{
    [super setFloat:value
             forKey:defaultName];
    _cacheDictionary[defaultName] = @(value);
    [self doSynchronize];
}



- (double)doubleForKey:(NSString *)defaultName
{
    double ret;
    if (_cacheDictionary[defaultName]) {
        ret = ((NSNumber *)_cacheDictionary[defaultName]).doubleValue;
    }
    else {
        ret = [super integerForKey:defaultName];
    }
    
    return ret;
}

- (void)setDouble:(double)value
           forKey:(NSString *)defaultName
{
    [super setDouble:value
              forKey:defaultName];
    _cacheDictionary[defaultName] = @(value);
    [self doSynchronize];
}



- (BOOL)boolForKey:(NSString *)defaultName
{
    BOOL ret;
    if (_cacheDictionary[defaultName]) {
        ret = ((NSNumber *)_cacheDictionary[defaultName]).boolValue;
    }
    else {
        ret = [super integerForKey:defaultName];
    }
    
    return ret;
}

- (void)setBool:(BOOL)value
         forKey:(NSString *)defaultName
{
    [super setBool:value
            forKey:defaultName];
    _cacheDictionary[defaultName] = @(value);
    [self doSynchronize];
}



- (NSURL *)URLForKey:(NSString *)defaultName
{
    return _cacheDictionary[defaultName]?: [super URLForKey:defaultName];
}

- (void)setURL:(NSURL *)url
        forKey:(NSString *)defaultName
{
    [super setURL:url
           forKey:defaultName];
    
    if (url) {
        _cacheDictionary[defaultName] = url;
    }
    else {
        [_cacheDictionary removeObjectForKey:defaultName];
    }
    [self doSynchronize];
}



/*!
 
 @override
 
 set _cacheDictionary too.
 
 */
- (void)registerDefaults:(NSDictionary *)registrationDictionary
{
    for (NSString *key in registrationDictionary.keyEnumerator) {
        if (!_cacheDictionary[key]) {
            _cacheDictionary[key] = registrationDictionary[key];
        }
    }
    
    [super registerDefaults:registrationDictionary];
}



#pragma mark class api

/*!
 
 @override NSObject
 
 call at first access to this class method (ex. alloc) once.
 create Singleton instance.
 
 */
+ (void)initialize
{
    sObject = DKUserDictionary.new;
}



/*!
 
 @getter
 
 return DKUserDictionary.
 or wrapped by protocol.
 
 */
+ (DKUserDictionary *)d
{
    return sObject;
}

+ (id<DKUserDictionaryNumber>)number
{
    return (id<DKUserDictionaryNumber>)sObject;
}

+ (id<DKUserDictionaryString>)string
{
    return (id<DKUserDictionaryString>)sObject;
}

+ (id<DKUserDictionaryArray>)array
{
    return (id<DKUserDictionaryArray>)sObject;
}

+ (id<DKUserDictionaryDictionary>)dictionary
{
    return (id<DKUserDictionaryDictionary>)sObject;
}

+ (id<DKUserDictionaryData>)data
{
    return (id<DKUserDictionaryData>)sObject;
}

+ (id<DKUserDictionaryURL>)URL
{
    return (id<DKUserDictionaryURL>)sObject;
}



+ (NSInteger(^)(NSString *))_integer
{
    return ^(NSString *key) {
        return [DKUserDictionary.number[key] integerValue];
    };
}

+ (void (^)(NSString *, NSInteger))_setInteger
{
    return ^(NSString *key, NSInteger _integer) {
        DKUserDictionary.number[key] = @(_integer);
    };
}



+ (float(^)(NSString *))_float
{
    return ^(NSString *key) {
        return [DKUserDictionary.number[key] floatValue];
    };
}

+ (void (^)(NSString *, float))_setFloat
{
    return ^(NSString *key, float _float) {
        DKUserDictionary.number[key] = @(_float);
    };
}



+ (double(^)(NSString *))_double
{
    return ^(NSString *key) {
        return [DKUserDictionary.number[key] doubleValue];
    };
}

+ (void (^)(NSString *, double))_setDouble
{
    return ^(NSString *key, double _double) {
        DKUserDictionary.number[key] = @(_double);
    };
}



+ (BOOL(^)(NSString *))_bool
{
    return ^(NSString *key) {
        return [DKUserDictionary.number[key] boolValue];
    };
}

+ (void (^)(NSString *, BOOL))_setBool
{
    return ^(NSString *key, BOOL _bool) {
        DKUserDictionary.number[key] = @(_bool);
    };
}



/*!
 
 @setter
 
 flag do synchroze when call setObject:forKeyedSubscript:.
 
 */
+ (void)setAutoSynchronize:(BOOL)yesOrNo
{
    sObject.autoSynchronize = yesOrNo;
}

@end
