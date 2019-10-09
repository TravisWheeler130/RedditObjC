//
//  TRWPostController.h
//  RedditStarteriOS29
//
//  Created by Travis Wheeler on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "TRWPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface TRWPostController : NSObject

@property (nonatomic, copy) NSArray<TRWPost *> * posts;

+(instancetype) sharedController;

-(void)fetchPosts:(void (^)(BOOL))completion;

-(void)fetchImageForPost:(TRWPost *)post completion:(void (^) (UIImage *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
