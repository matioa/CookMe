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

@end
