//
//  SHScholarshipsFavoritesTableViewController.m
//  Topent
//
//  Created by Shuaib Yunus on 10/03/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import "SHScholarshipsFavoritesTableViewController.h"

@interface SHScholarshipsFavoritesTableViewController ()

@property (retain, nonatomic) NSString *favoritesKey;

@end

@implementation SHScholarshipsFavoritesTableViewController

@synthesize favoritesList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _favoritesKey = @"scholarshipsFavorites";
    NSMutableArray *favorites;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    favorites = [[standardUserDefaults objectForKey:_favoritesKey] mutableCopy];
    if (favorites == nil) {
        favorites = [[NSMutableArray alloc] init];
        [standardUserDefaults setObject:favorites forKey:_favoritesKey];
        [standardUserDefaults synchronize];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [favoritesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"scholarshipsFavoritesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [[standardUserDefaults objectForKey:_favoritesKey] mutableCopy];
    
    NSString *listItem = [[favoritesList allObjects] objectAtIndex:indexPath.row];
    
    if ([favorites containsObject:listItem])
    {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.textLabel.text = [[favoritesList allObjects] objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"-";
    
    }
    else {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.textLabel.text = [[favoritesList allObjects] objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"+";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *selectedFavorite = cell.textLabel.text;
    
    // Store the data
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [[standardUserDefaults objectForKey:_favoritesKey] mutableCopy];
    
    if ([favorites containsObject:selectedFavorite])
    {
        [favorites removeObject:selectedFavorite];
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.text = @"+";
    }
    else
    {
        [favorites addObject:selectedFavorite];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.text = @"-";
    }

    [standardUserDefaults setObject:favorites forKey:_favoritesKey];
    [standardUserDefaults synchronize];
}

@end
