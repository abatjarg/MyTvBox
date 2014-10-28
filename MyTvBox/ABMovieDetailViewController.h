//
//  ABMovieDetailViewController.h
//  MyTvBox
//
//  Created by Ariunjargal on 10/27/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABMovie.h"

@interface ABMovieDetailViewController : UIViewController

@property (strong, nonatomic) ABMovie *movie;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieOverview;

@end
