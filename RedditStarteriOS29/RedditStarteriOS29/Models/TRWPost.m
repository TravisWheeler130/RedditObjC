//
//  TRWPost.m
//  RedditStarteriOS29
//
//  Created by Travis Wheeler on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import "TRWPost.h"

static NSString * const kTitleKey = @"title";
static NSString * const kThumbnailKey = @"thumbnail";

@implementation TRWPost

- (TRWPost *)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail
{
    self = [super init];
    if (self)
    {
        _title = title;
        _thumbnail = thumbnail;
    }
    return self;
}

@end

@implementation TRWPost (JSONConvertable)

- (TRWPost *)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString * title = dictionary[kTitleKey];
    NSString * thumbnail = dictionary[kThumbnailKey];
    
    return [self initWithTitle:title thumbnail:thumbnail];
}

@end
