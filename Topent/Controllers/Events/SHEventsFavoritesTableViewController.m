//
//  SHEventsFavoritesTableViewController.m
//  Topent
//
//  Created by Shuaib Yunus on 22/03/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import "SHEventsFavoritesTableViewController.h"

@interface SHEventsFavoritesTableViewController ()

@property (retain, nonatomic) NSString *favoritesKey;

@end

@implementation SHEventsFavoritesTableViewController

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
    
    _favoritesKey = @"eventsFavorites";
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
    static NSString *CellIdentifier = @"eventsFavoritesCell";
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

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
