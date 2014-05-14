//
//  ViewController.m
//  DKUserDictionarySample
//
//  Created by daisuke on 2014/03/11.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//



#import "ViewController.h"
#import "DKUserDictionary.h"



#define TLog(fmt, ...) NSLog((@"%d: "fmt), __LINE__, ##__VA_ARGS__)



@interface ViewController ()

@end



@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *u = NSUserDefaults.standardUserDefaults;
    
    [DKUserDictionary setAutoSynchronize:NO];
    
    // test cache because cannot test in XCTest
    DKUserDictionary.d[@"name"] = @"daisuke";
    TLog(@"%@", [self doTest:([[u objectForKey:@"name"] isEqualToString:@"daisuke"])]);
    
    DKUserDictionary.d[@"name"] = nil;
    TLog(@"%@", [self doTest:(![u objectForKey:@"name"])]);
    
    NSLog(@"%d", (int)DKUserDictionary._integer(@"test"));
    NSLog(@"%d", (int)[u objectForKey:@"test"]);
    
    DKUserDictionary.data[@"data"] = [@"" dataUsingEncoding:NSUTF8StringEncoding];
}



- (void)viewWillAppear:(BOOL)animated
{
    NSString *name = DKUserDictionary.string[@"name"];
    NSString *developer = DKUserDictionary.string[@"developer"];
    NSString *version = DKUserDictionary.string[@"version"];
    NSNumber *init = DKUserDictionary.number[@"init"];
    
    DKUserDictionary.d[@"name"] = name;
    DKUserDictionary.string[@"developer"] = developer;
    DKUserDictionary.string[@"version"] = version;
    DKUserDictionary.number[@"init"] = init;
}



- (NSString *)doTest:(BOOL)okOrNot
{
    return okOrNot ? @"Ok" : @"!!!! Miss";
}


@end
