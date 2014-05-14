DKUserDictionary
================

# @description

This class can easiliy use NSUserDefaults like NSDictionary.



# @how to use

You can use like NSDictionary.

    DKUserDictionary.d[@"version"] = @"1.0.0";
    NSString *version = DKUserDictionary.d[@"version"];

    // and use conscious of the type. 

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
    
    // not object
    NSInteger _integer = DKUserDictionary._integer(@"integer");
    float _float = DKUserDictionary._float(@"float");
    double _double = DKUserDictionary._double(@"double");
    BOOL _bool = DKUserDictionary._bool(@"bool");
    DKUserDictionary._setInteger(@"integer", 100);
    DKUserDictionary._setFloat(@"float", 100.f);
    DKUserDictionary._setDouble(@"double", 100.f);
    DKUserDictionary._setBool(@"bool", YES);
    
    
    // DKUserDictionary cache default, so not neccessary call synchronize.
    // because regist and get/set call through DKUserDefaults.
    // cache have old saved defaults too.
    
    [DKUserDictionary.d registerDefaults:@{@"register": @"register"}];

