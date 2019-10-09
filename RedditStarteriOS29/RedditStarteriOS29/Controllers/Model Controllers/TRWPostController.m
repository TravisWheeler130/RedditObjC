//
//  TRWPostController.m
//  RedditStarteriOS29
//
//  Created by Travis Wheeler on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import "TRWPostController.h"

static NSString * const kBaseURLString = @"https://www.reddit.com";
static NSString * const kRComponentString = @"r";
static NSString * const kFunnyComponent = @"funny";
static NSString * const kJSONExtension = @"json";

//"https://www.reddit.com/r/funny.json"

@implementation TRWPostController

+ (instancetype)sharedController
{
    static TRWPostController * sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[TRWPostController alloc] init];
    });
    return sharedController;
}

- (void)fetchPosts:(void (^)(BOOL))completion
{
    NSURL * url = [NSURL URLWithString:kBaseURLString];
    NSURL * rUrl = [url URLByAppendingPathComponent:kRComponentString];
    NSURL * funnyURL = [rUrl URLByAppendingPathComponent:kFunnyComponent];
    NSURL * finalURL = [funnyURL URLByAppendingPathExtension:kJSONExtension];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching post: %@", error);
            completion(false);
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"Error with fetched post data");
            completion(false);
            return;
        }
        
        NSDictionary * topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        if (error)
        {
            NSLog(@"Error parsing JSON data: %@", [error localizedDescription]);
            completion(false);
            return;
        }
        
        NSDictionary * secondLevelJson = topLevelJSON[@"data"];
        
        NSArray<NSDictionary *> * thirdLevelJson = secondLevelJson[@"children"];
        
        NSMutableArray * arrayOfPost = [NSMutableArray new];
        
        for (NSDictionary * currentDictionary in thirdLevelJson)
        {
            NSDictionary * postDictionary = currentDictionary[@"data"];
            TRWPost * post = [[TRWPost alloc] initWithDictionary:postDictionary];
            [arrayOfPost addObject:post];
        }
        if (arrayOfPost.count != 0)
        {
            TRWPostController.sharedController.posts = arrayOfPost;
            completion(true);
        } else {
            completion(false);
        }
        
    }]resume];
}

- (void)fetchImageForPost:(TRWPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL * url = [NSURL URLWithString: post.thumbnail];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error fetching post image: %@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error with fetched post image data");
            completion(nil);
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }]resume];
}

@end
