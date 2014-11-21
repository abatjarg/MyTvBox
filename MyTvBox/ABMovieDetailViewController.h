//
//  ABMovieDetailViewController.h
//  MyTvBox
//
//  Created by Ariunjargal on 10/27/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABMovie.h"

@interface ABMovieDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ABMovie *movie;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

- (IBAction)playTrailerButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@end
