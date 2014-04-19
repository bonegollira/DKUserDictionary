DKUserDictionary
================

# @description

This class can easiliy use NSUserDefaults like NSDictionary.



# @how to use

You can use like NSDictionary.

    DKUserDictionary.d[@"version"] = @"1.0.0";
    NSString *version = DKUserDictionary.d[@"version"];

    // and use conscious of the type (only objects)

    DKUserDictionary *d = DKUserDictionary.d;
    NSNumber *num = DKUserDictionary.number[@"number"]; // also DKUserDictionary.d[@"number"]
    NSString *str = DKUserDictionary.string[@"string"]; // also DKUserDictionary.d[@"string"]
    NSArray *arr = DKUserDictionary.array[@"array"]; // also DKUserDictionary.d[@"array"]
    NSDictionary *dic = DKUserDictionary.dictionary[@"dictionary"]; // also DKUserDictionary.d[@"dictionary"]
    NSData *data = DKUserDictionary.data[@"data"]; // also DKUserDictionary.d[@"data"]
    NSURL *URL = DKUserDictionary.URL[@"URL"]; // also DKUserDictionary.d[@"URL"]
    
    // DKUserDictionary cache default, so not neccessary call synchronize.
    // because regist and get/set call through DKUserDefaults.
    // cache have old saved defaults too.
    
    [DKUserDictionary.d registerDefaults:@{@"register": @"register"}];



# !!
integerForKey, floatForKey... cannot impl because -(int)objectForKeyedSubscript: dosent work.
 
