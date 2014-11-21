//
//  ABMovieDetailViewController.m
//  MyTvBox
//
//  Created by Ariunjargal on 10/27/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import "ABMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ABReviewCell.h"

@interface ABMovieDetailViewController ()

@property (strong, nonatomic) NSString *rottenTomatoesID;
@property (strong, nonatomic) NSMutableArray *reviews;

@end

@implementation ABMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.posterView setImageWithURL:[NSURL URLWithString:[self grabImageUrl:self.movie.imageUrl]]];
    self.movieTitle.text = self.movie.title;
    [self loadData];
    //[self loadReviewData];
    
    self.reviewTableView.rowHeight = 80;
    self.reviewTableView.dataSource = self;
    self.reviewTableView.delegate = self;
    
    [self.reviewTableView registerNib:[UINib nibWithNibName:@"ABReviewCell" bundle:nil] forCellReuseIdentifier:@"ABReviewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)grabImageUrl:(NSString *)secondPart
{
    NSString *firstPart = @"http://image.tmdb.org/t/p/w500/";
    NSString *url = [NSString stringWithFormat:@"%@%@", firstPart, secondPart];
    return url;
}

- (void)loadData
{
    NSString *url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?id=%@&type=imdb&apikey=deucvtu94kwb63bvt28wf9xa", self.movie.imdbID];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!connectionError && responseCode == 200) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", object[@"id"]);
            [self loadReviewData:object[@"id"]];
        }
        else
        {
            NSLog(@"Error!!!");
        }
        
    }];
}

- (void)loadReviewData:(NSString *)rottenTomatoesID
{
    //NSLog(@"%@", self.rottenTomatoesID);
    NSString *url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%@/reviews.json?review_type=top_critic&page_limit=20&page=1&country=us&apikey=deucvtu94kwb63bvt28wf9xa", rottenTomatoesID];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!connectionError && responseCode == 200) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.reviews = [[NSMutableArray alloc]initWithArray:[object objectForKey:@"reviews"]];
            [self.reviewTableView reloadData];
        }
        else
        {
            NSLog(@"Error!!!");
        }
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playTrailerButtonPressed:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=q94n3eWOWXM"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.reviews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ABReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABReviewCell"];
    NSLog(@"%@", self.reviews);
    cell.criticNameLabel.text = self.reviews[indexPath.row][@"critic"];
    cell.reviewLabel.text = self.reviews[indexPath.row][@"quote"];
    return cell;
}

//- (IBAction)changeBetweenDetailReview:(UISegmentedControl *)sender
//{
//    NSInteger selectedSegment = sender.selectedSegmentIndex;
//    if (selectedSegment == 0) {
//        self.reviewTableView.hidden = YES;
//        self.detailView.hidden = NO;
//    }else if(selectedSegment == 1){
//        self.reviewTableView.hidden = NO;
//        self.detailView.hidden = YES;
//    }
//}



@end



















