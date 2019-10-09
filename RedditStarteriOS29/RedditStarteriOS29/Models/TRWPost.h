//
//  TRWPost.h
//  RedditStarteriOS29
//
//  Created by Travis Wheeler on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TRWPost : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString * title;
@property (nonatomic, copy, readonly, nullable) NSString *thumbnail;

- (TRWPost *)initWithTitle:(NSString *)title
                 thumbnail:(NSString *)thumbnail;

@end

@interface TRWPost (JSONConvertable)

-(TRWPost *)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
