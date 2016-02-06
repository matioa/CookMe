//
//  MAHttpRequest.m
//  CookMe
//
//  Created by BackendServTestUser on 2/5/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

#import "MAHttpRequest.h"

@implementation MAHttpRequest

- (void)getRequest:(NSString *)urlStr withCompletionHandler:(void (^)(NSDictionary * __nullable dict))completionHandler{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
        completionHandler(dict);
        
    }]
     resume];

}

+(NSString*)urlStringWithQuery: (NSString*)query
                             from:(int) from
                            andTo:(int) to{
    NSString *appId = @"a59f1e83";
    NSString *appKey = @"a5564ce4d5d3669027e28477164dd0ef";
    NSString *urlStr = [NSString stringWithFormat:@"https://api.edamam.com/search?q=%@&from=%d&to=%d&app_id=%@&app_key=%@", query, from, to, appId, appKey];
    
    return urlStr;
}

@end
