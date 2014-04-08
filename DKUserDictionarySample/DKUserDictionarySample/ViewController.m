//
//  ViewController.m
//  DKUserDictionarySample
//
//  Created by daisuke on 2014/03/11.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//



#import "ViewController.h"
#import "DKUserDictionary.h"



@interface ViewController ()

@end



@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *labels = @[].mutableCopy;
    
    CGFloat scrollHeight = 0.f;
    for (UIView *label in labels) {
        scrollHeight += label.bounds.size.height;
    }
    
    UIScrollView *scrollView = UIScrollView.new;
    scrollView.frame = (CGRect) {
        .size = self.view.bounds.size
    };
    scrollView.contentSize = (CGSize) {
        .width = scrollView.bounds.size.width,
        .height = scrollHeight
    };
    [self.view addSubview:scrollView];
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



@end
