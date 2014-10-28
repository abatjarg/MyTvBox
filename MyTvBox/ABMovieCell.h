//
//  ABMovieCell.h
//  MyTvBox
//
//  Created by Ariunjargal on 10/25/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABMovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieGenre;

@end
