//
//  DKUserDictionaryTests.m
//  DKUserDictionarySample
//
//  Created by daisuke on 2014/03/13.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "DKUserDictionary.h"



@interface DKUserDictionaryTests : XCTestCase

@end



@implementation DKUserDictionaryTests



- (void)setUp
{
    [super setUp];
}



- (void)tearDown
{
    [super tearDown];
}



- (void)clear:(NSArray *)keys
{
    for (NSString *key in keys) {
        [DKUserDictionary.d removeObjectForKey:key];
        [DKUserDictionary.d synchronize];
    }
}



#pragma mark DKUserDictionaryTests

- (void)testRestore
{
    NSUserDefaults *u = NSUserDefaults.standardUserDefaults;
    // regist save state during launching app.
    [u registerDefaults:@{
                          @"oldRegistedCacheTest": @"oldRegistedCacheTest"
                          }];
    [u setObject:@"oldSavedCacheTest"
          forKey:@"oldSavedCacheTest"];
    [u synchronize];
    
    // check restore old saved defaults.
    XCTAssertEqualObjects(DKUserDictionary.d[@"oldRegistedCacheTest"], @"oldRegistedCacheTest");
    XCTAssertEqualObjects(DKUserDictionary.d[@"oldSavedCacheTest"], @"oldSavedCacheTest");
    
    // clear
    [self clear:@[@"oldRegistedCacheTest", @"oldSavedCacheTest"]];
}



- (void)testCache
{
    NSUserDefaults *u = NSUserDefaults.standardUserDefaults;
    NSString *key = @"cacheTest";
    
    // not saved state to local by not using [u synchronize].
    
    // setObject:forKey:
    // not be same state DKUserDictionary and NSUserDefaults.
    DKUserDictionary.d[key] = @"cacheTest";
    XCTAssertEqualObjects(DKUserDictionary.d[key], @"cacheTest");
//    XCTAssertNotEqualObjects([u objectForKey:key], @"cacheTest");
    
    // be same state DKUserDictionary and NSUserDefaults.
    [DKUserDictionary.d synchronize];
    XCTAssertEqualObjects(DKUserDictionary.d[key], @"cacheTest");
    XCTAssertEqualObjects([u objectForKey:key], @"cacheTest");
    
    // removeObjectForKey.
    // not be same state DKUserDictionary and NSUserDefaults.
    [DKUserDictionary.d removeObjectForKey:key];
    XCTAssertNil(DKUserDictionary.d[key]);
//    XCTAssertNotNil([u objectForKey:key]);
    
    // be same state DKUserDictionary and NSUserDefaults.
    [DKUserDictionary.d synchronize];
    XCTAssertNil(DKUserDictionary.d[key]);
    XCTAssertNil([u objectForKey:key]);
    
    // NSUserDefaults経由で保存されると値の変更をcacheが検知できない
    DKUserDictionary.d[key] = @"cacheTest";
    [u removeObjectForKey:key];
    // TODO:
    XCTAssertEqualObjects(DKUserDictionary.d[key], @"cacheTest");
    // clear
    [DKUserDictionary.d removeObjectForKey:key];
}



- (void)testAccessor
{
    // DKUserDictioanry
    NSString *key = @"accessorTest";
    XCTAssertNil(DKUserDictionary.d[key]);
    DKUserDictionary.d[key] = @"accessorTest";
    XCTAssertEqualObjects(DKUserDictionary.d[key], @"accessorTest");
    DKUserDictionary.d[key] = @"accessorTestV2";
    XCTAssertEqualObjects(DKUserDictionary.d[key], @"accessorTestV2");
    DKUserDictionary.d[key] = nil;
    XCTAssertNil(DKUserDictionary.d[key]);
    
    // id<DKUserDictionaryNumber>
    NSString *keyNumber = @"accessorTestNumber";
    XCTAssertNil(DKUserDictionary.number[keyNumber]);
    DKUserDictionary.number[keyNumber] = @(95);
    XCTAssertEqualObjects(DKUserDictionary.d[keyNumber], @(95));
    DKUserDictionary.number[keyNumber] = @(100);
    XCTAssertEqualObjects(DKUserDictionary.number[keyNumber], @(100));
    DKUserDictionary.number[keyNumber] = nil;
    XCTAssertNil(DKUserDictionary.number[keyNumber]);
    
    // id<DKUserDictionaryString>
    NSString *keyString = @"accessorTestString";
    XCTAssertNil(DKUserDictionary.string[keyString]);
    DKUserDictionary.string[keyString] = @"accessorTestString";
    XCTAssertEqualObjects(DKUserDictionary.string[keyString], @"accessorTestString");
    DKUserDictionary.string[keyString] = @"accessorTestStringV2";
    XCTAssertEqualObjects(DKUserDictionary.string[keyString], @"accessorTestStringV2");
    DKUserDictionary.string[keyString] = nil;
    XCTAssertNil(DKUserDictionary.string[keyString]);
    
    // id<DKUserDictioanryArray>
    NSString *keyArray = @"accessorTestArray";
    XCTAssertNil(DKUserDictionary.array[keyArray]);
    DKUserDictionary.array[keyArray] = @[@"accessorTestArray"];
    XCTAssertEqualObjects(DKUserDictionary.array[keyArray], @[@"accessorTestArray"]);
    DKUserDictionary.array[keyArray] = @[@"accessorTestArrayV2"];
    XCTAssertEqualObjects(DKUserDictionary.array[keyArray], @[@"accessorTestArrayV2"]);
    DKUserDictionary.array[keyArray] = nil;
    XCTAssertNil(DKUserDictionary.array[keyArray]);
    
    // id<DKUserDictionaryDictionary>
    NSString *keyDictionary = @"accessorTestDictionary";
    XCTAssertNil(DKUserDictionary.dictionary[keyDictionary]);
    DKUserDictionary.dictionary[keyDictionary] = @{@"accessorTestDictionary": @"accessorTestDictionary"};
    XCTAssertEqualObjects(DKUserDictionary.dictionary[keyDictionary], @{@"accessorTestDictionary": @"accessorTestDictionary"});
    DKUserDictionary.dictionary[keyDictionary] = @{@"accessorTestDictionaryV2": @"accessorTestDictionaryV2"};
    XCTAssertEqualObjects(DKUserDictionary.dictionary[keyDictionary], @{@"accessorTestDictionaryV2": @"accessorTestDictionaryV2"});
    DKUserDictionary.dictionary[keyDictionary] = nil;
    XCTAssertNil(DKUserDictionary.dictionary[keyDictionary]);
    
    // id<DKUserDictionaryData>
    NSString *keyData = @"accessorTestData";
    XCTAssertNil(DKUserDictionary.data[keyData]);
    DKUserDictionary.data[keyData] = [@"accessorTestData" dataUsingEncoding:NSUTF8StringEncoding];
    XCTAssertEqualObjects(DKUserDictionary.data[keyData], [@"accessorTestData" dataUsingEncoding:NSUTF8StringEncoding]);
    DKUserDictionary.data[keyData] = [@"accessorTestDataV2" dataUsingEncoding:NSUTF8StringEncoding];
    XCTAssertEqualObjects(DKUserDictionary.data[keyData], [@"accessorTestDataV2" dataUsingEncoding:NSUTF8StringEncoding]);
    DKUserDictionary.data[keyData] = nil;
    XCTAssertNil(DKUserDictionary.data[keyData]);
    
    // id<DKUserDictinaryURL>
    NSString *keyURL = @"accessorTestURL";
    XCTAssertNil(DKUserDictionary.URL[keyURL]);
    DKUserDictionary.URL[keyURL] = [NSURL URLWithString:@"http://m.yahoo.co.jp"];
    XCTAssertEqualObjects(DKUserDictionary.URL[keyURL], [NSURL URLWithString:@"http://m.yahoo.co.jp"]);
    DKUserDictionary.URL[keyURL] = [NSURL URLWithString:@"http://auction.yahoo.co.jp"];
    XCTAssertEqualObjects(DKUserDictionary.URL[keyURL], [NSURL URLWithString:@"http://auction.yahoo.co.jp"]);
    DKUserDictionary.URL[keyURL] = nil;
    XCTAssertNil(DKUserDictionary.URL[keyURL]);
}

/*!
 
 integer, setInteger
 
 */
- (void)testInteger
{
    NSString *keyInteger = @"accessorTestInteger";
    XCTAssertEqual(DKUserDictionary._integer(keyInteger), 0);
    DKUserDictionary._setInteger(keyInteger, 100);
    XCTAssertEqual(DKUserDictionary._integer(keyInteger), 100);
    DKUserDictionary._setInteger(keyInteger, 200);
    XCTAssertEqual(DKUserDictionary._integer(keyInteger), 200);
    DKUserDictionary._setInteger(keyInteger, 0);
    XCTAssertEqual(DKUserDictionary._integer(keyInteger), 0);
}

/*!
 
 float, setFloat
 
 */
- (void)testFloat
{
    NSString *keyFloat = @"accessorTestFloat";
    XCTAssertEqual(DKUserDictionary._float(keyFloat), 0.0);
    DKUserDictionary._setFloat(keyFloat, 100.f);
    XCTAssertEqual(DKUserDictionary._float(keyFloat), 100.f);
    DKUserDictionary._setFloat(keyFloat, 200.f);
    XCTAssertEqual(DKUserDictionary._float(keyFloat), 200.f);
    DKUserDictionary._setFloat(keyFloat, 0.f);
    XCTAssertEqual(DKUserDictionary._float(keyFloat), 0.f);
}

/*!
 
 double, setDouble
 
 */
- (void)testDouble
{
    NSString *keyDouble = @"accessorTestDouble";
    XCTAssertEqual(DKUserDictionary._double(keyDouble), 0.f);
    DKUserDictionary._setInteger(keyDouble, 100.f);
    XCTAssertEqual(DKUserDictionary._double(keyDouble), 100.f);
    DKUserDictionary._setInteger(keyDouble, 200.f);
    XCTAssertEqual(DKUserDictionary._double(keyDouble), 200.f);
    DKUserDictionary._setInteger(keyDouble, 0.f);
    XCTAssertEqual(DKUserDictionary._double(keyDouble), 0.f);
}

/*!
 
 BOOL, setBOOL
 
 */
- (void)testBOOL
{
    NSString *keyBOOL = @"accessorTestBOOL";
    XCTAssertEqual(DKUserDictionary._bool(keyBOOL), NO);
    DKUserDictionary._setBool(keyBOOL, YES);
    XCTAssertEqual(DKUserDictionary._bool(keyBOOL), YES);
    DKUserDictionary._setBool(keyBOOL, NO);
    XCTAssertEqual(DKUserDictionary._bool(keyBOOL), NO);
}



- (void)testAutoSynchronize
{
    NSUserDefaults *u = NSUserDefaults.standardUserDefaults;
    DKUserDictionary.d[@"autoSynchronize"] = @"startAutoSynchronize";
    DKUserDictionary.d[@"autoSynchronize"] = @"beforeAutoSynchronize";
//    XCTAssertNotEqualObjects(DKUserDictionary.d[@"autoSynchronize"], [u objectForKey:@"autoSynchronize"]);
    [DKUserDictionary setAutoSynchronize:YES];
    DKUserDictionary.d[@"autoSynchronize"] = @"afterAutoSynchronize";
    XCTAssertEqualObjects(DKUserDictionary.d[@"autoSynchronize"], [u objectForKey:@"autoSynchronize"]);
    [DKUserDictionary setAutoSynchronize:NO];
}



@end
