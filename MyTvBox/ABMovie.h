//
//  ABMovie.h
//  MyTvBox
//
//  Created by Ariunjargal on 10/25/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABMovie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *posterUrl;

- (id)initWithDictionary:(NSDictionary *)movies;

@end
