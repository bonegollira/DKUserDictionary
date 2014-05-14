//
//  DKUserDictionary.h
//  DKUserDictionarySample
//
//  Created by daisuke on 2014/03/11.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//



#import <Foundation/Foundation.h>



@protocol DKUserDictionaryNumber;
@protocol DKUserDictionaryString;
@protocol DKUserDictionaryArray;
@protocol DKUserDictionaryDictionary;
@protocol DKUserDictionaryData;
@protocol DKUserDictionaryURL;



/*!
 
 @description
 This class can easiliy use NSUserDefaults like NSDictionary.
 
 @how to use
 
 ::
 :: You can use like NSDictionary.
 ::
 
 DKUserDictionary.d[@"version"] = @"1.0.0";
 NSString *version = DKUserDictionary.d[@"version"];
 
 ::
 :: and use conscious of the type (only objects)
 ::
 
 DKUserDictionary *d = DKUserDictionary.d;
 NSNumber *num = DKUserDictionary.number[@"number"]; // also DKUserDictionary.d[@"number"]
 NSString *str = DKUserDictionary.string[@"string"]; // also DKUserDictionary.d[@"string"]
 NSArray *arr = DKUserDictionary.array[@"array"]; // also DKUserDictionary.d[@"array"]
 NSDictionary *dic = DKUserDictionary.dictionary[@"dictionary"]; // also DKUserDictionary.d[@"dictionary"]
 NSData *data = DKUserDictionary.data[@"data"]; // also DKUserDictionary.d[@"data"]
 NSURL *URL = DKUserDictionary.URL[@"URL"]; // also DKUserDictionary.d[@"URL"]
 
 DKUserDictionary.number[@"number"] = @(100); // also DKUserDictionary.d[@"number"]
 DKUserDictionary.string[@"string"] = @"foo"; // also DKUserDictionary.d[@"string"]
 DKUserDictionary.array[@"array"] = @[@"arrya"]; // also DKUserDictionary.d[@"array"]
 DKUserDictionary.dictionary[@"dictionary"] = @{@"key": @"value"}; // also DKUserDictionary.d[@"dictionary"]
 DKUserDictionary.data[@"data"] = [@"" dataUsingEncoding:NSUTF8StringEncoding]; // also DKUserDictionary.d[@"data"]
 DKUserDictionary.URL[@"URL"] = [NSURL URLWithString:@"http://xxx.com"]; // also DKUserDictionary.d[@"URL"]
 
 ::
 :: not object
 ::
 
 NSInteger _integer = DKUserDictionary._integer(@"integer");
 float _float = DKUserDictionary._float(@"float");
 double _double = DKUserDictionary._double(@"double");
 BOOL _bool = DKUserDictionary._bool(@"bool");
 DKUserDictionary._setInteger(@"integer", 100);
 DKUserDictionary._setFloat(@"float", 100.f);
 DKUserDictionary._setDouble(@"double", 100.f);
 DKUserDictionary._setBool(@"bool", YES);

 
 ::
 :: DKUserDictionary cache default, so not neccessary call synchronize.
 :: because regist and get/set call through DKUserDefaults.
 :: cache have old saved defaults too.
 ::
 
 [DKUserDictionary.d registerDefaults:@{@"register": @"register"}];
 
 */
@interface DKUserDictionary : NSUserDefaults



@property (nonatomic) BOOL autoSynchronize;



/*!
 
 for "id dk = dkUserDictionary[@"dk"];"
 
 kick [dkUserDictionaryObject objectForKeyedSubscript:].
 
 */
- (id)objectForKeyedSubscript:(id)key;

/*!
 
 for "dkUserDictionary[@"dk"] = @"dk";"
 
 kick [dkUserDictionaryObject setObject:forKeyedSubscript:].
 
 */
- (void)setObject:(id)object
forKeyedSubscript:(id<NSCopying>)key;



+ (DKUserDictionary *)d;
+ (id<DKUserDictionaryNumber>)number;
+ (id<DKUserDictionaryString>)string;
+ (id<DKUserDictionaryArray>)array;
+ (id<DKUserDictionaryDictionary>)dictionary;
+ (id<DKUserDictionaryData>)data;
+ (id<DKUserDictionaryURL>)URL;

+ (NSInteger(^)(NSString *))_integer;
+ (float(^)(NSString *))_float;
+ (double(^)(NSString *))_double;
+ (BOOL(^)(NSString *))_bool;

+ (void(^)(NSString *, NSInteger))_setInteger;
+ (void(^)(NSString *, float))_setFloat;
+ (void(^)(NSString *, double))_setDouble;
+ (void(^)(NSString *, BOOL))_setBool;

+ (void)setAutoSynchronize:(BOOL)yesOrNo;



@end



#pragma mark protocol

@protocol DKUserDictionaryInteger <NSObject>

- (void (^)(int))setObject:(NSString *)string
         forKeyedSubscript:(id<NSCopying>)key;

@end


////

@protocol DKUserDictionaryString <NSObject>

- (NSString *)objectForKeyedSubscript:(id)key;
- (void)setObject:(NSString *)string
forKeyedSubscript:(id<NSCopying>)key;

@end



@protocol DKUserDictionaryArray <NSObject>

- (NSArray *)objectForKeyedSubscript:(id)key;
- (void)setObject:(NSArray *)array
forKeyedSubscript:(id<NSCopying>)key;

@end



@protocol DKUserDictionaryDictionary <NSObject>

- (NSDictionary *)objectForKeyedSubscript:(id)key;
- (void)setObject:(NSDictionary *)dictionary
forKeyedSubscript:(id<NSCopying>)key;

@end



@protocol DKUserDictionaryData <NSObject>

- (NSData *)objectForKeyedSubscript:(id)key;
- (void)setObject:(NSData *)data
forKeyedSubscript:(id<NSCopying>)key;

@end



@protocol DKUserDictionaryNumber <NSObject>

- (NSNumber *)objectForKeyedSubscript:(id)key;
- (void)setObject:(NSNumber *)number
forKeyedSubscript:(id<NSCopying>)key;

@end



@protocol DKUserDictionaryURL <NSObject>

- (NSURL *)objectForKeyedSubscript:(id)key;
- (void)setObject:(NSURL *)URL
forKeyedSubscript:(id<NSCopying>)key;

@end
