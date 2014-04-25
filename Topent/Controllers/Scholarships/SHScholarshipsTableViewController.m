//
//  SHScholarshipsTableViewController.m
//  Topent
//
//  Created by Shuaib Yunus on 24/01/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import "SHScholarshipsTableViewController.h"
#import "SHAppDelegate.h"
#import "SHScholarshipsDetailedViewController.h"
#import "SHScholarshipsFavoritesTableViewController.h"

const int kLoadingCellTag = 1273;

@interface SHScholarshipsTableViewController ()

@property (nonatomic, strong)NSMutableArray *objects;
@property (nonatomic, strong)NSMutableArray *sortedDataSource;
@property (nonatomic, strong)NSMutableArray *userFavorites;
@property (nonatomic, strong)NSMutableSet *favoritesList;
@property (nonatomic, strong)NSString *parseClassName;
@property (nonatomic, strong)NSString *favoritesKey;
@property (nonatomic, strong)PFObject *selectedScholarship;
@property (nonatomic, assign)int objectsPerPage;
@property (nonatomic, assign)int currentPage;
@property (nonatomic, assign)int totalPages;
@property (nonatomic, assign)BOOL doneLoading;

@end

@implementation SHScholarshipsTableViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Scholarship";
        self.favoritesKey = @"scholarshipsFavorites";
        self.favoritesList = [[NSMutableSet alloc] init];
        self.objects = [NSMutableArray array];
        self.sortedDataSource = [NSMutableArray array];
        self.objectsPerPage = 5;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.currentPage = 0;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(retrievingDataFromParse) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    _userFavorites = [[standardUserDefaults objectForKey:_favoritesKey] mutableCopy];
    
    if (!_userFavorites) {
        _userFavorites = [[NSMutableArray alloc] init];
        [standardUserDefaults setObject:_userFavorites forKey:_favoritesKey];
        [standardUserDefaults synchronize];
    }
    
    //[self retrievingDataFromParse];
}

- (void)stopRefresh {
    [self.refreshControl endRefreshing];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.currentPage == 0) {
        return 1;
    }
    
    if (self.currentPage < self.totalPages) {
        return self.objects.count + 1;
    }
    
    return [self.objects count];
}

- (void)retrieveDataCallback:(NSArray *)parseObjects error:(NSError *)error {
    if (!error) {
        // The find succeeded.
        self.doneLoading = YES;
        NSLog(@"Successfully retrieved %lu scholarships.", (unsigned long)parseObjects.count);
        
        // Sort data
        
        NSMutableArray *favorited = [[NSMutableArray alloc] init];
        NSMutableArray *nonFavorited = [[NSMutableArray alloc] init];
        
        for (PFObject *object in parseObjects) {
            NSArray *tags = [object objectForKey:@"tags"];
            for (NSString *tag in tags) {
                [self.favoritesList addObject:tag];
                if ([_userFavorites containsObject:tag]) {
                    [favorited addObject:object];
                    break;
                } else if ([tag isEqualToString:[tags lastObject]]) {
                    [nonFavorited addObject:object];
                }
            }
        }
        
        NSLog(@"Favorites: %lu", (unsigned long)favorited.count);
        NSLog(@"None favorites: %lu", (unsigned long)nonFavorited.count);
        
        self.objects  = [favorited mutableCopy];
        [self.objects addObjectsFromArray:nonFavorited];
        
        self.totalPages = ceil(self.objects.count / self.objectsPerPage);
        
        NSLog(@"Total Pages: %d", self.totalPages);
        
        for (PFObject *obj in self.objects) {
            NSLog(@"Name: %@", [obj objectForKey:@"name"]);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.tableView reloadData];
        });
        
    } else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
}

-(void) retrievingDataFromParse {
    NSLog(@"%@", self.parseClassName);
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithTarget:self
                                    selector:@selector(retrieveDataCallback:error:)];
    
    [self performSelector:@selector(stopRefresh) withObject:nil];
}

- (UITableViewCell *)scholarshipCellForIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"scholarshipCell";
    PFObject *parseObjectForCell = [self.objects objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.text = [parseObjectForCell objectForKey:@"name"];
    cell.detailTextLabel.text = [parseObjectForCell objectForKey:@"summary"];
    
    _selectedScholarship = parseObjectForCell;
    
    return cell;

}

- (UITableViewCell *)loadingCell {
    UITableViewCell *cell = [[UITableViewCell alloc]
                              initWithStyle:UITableViewCellStyleDefault
                              reuseIdentifier:nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = cell.center;
    [cell addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    cell.tag = kLoadingCellTag;
    
    return cell;
}

// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.objects.count) {
        return [self scholarshipCellForIndexPath:indexPath];
    } else {
        return [self loadingCell];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (cell.tag == kLoadingCellTag) {
        self.currentPage++;
        [self retrievingDataFromParse];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"displayDetailedScholarship"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        
        NSLog(@"Selected Object: %@", [object objectForKey:@"name"]);
        
        // Set destination view controller to DetailViewController to avoid the NavigationViewController in the middle (if you have it embedded into a navigation controller, if not ignore that part)
        //UINavigationController *nav = [segue destinationViewController];
        //SHScholarshipsDetailedViewController *detailViewController = (SHScholarshipsDetailedViewController *) nav.topViewController;
        SHScholarshipsDetailedViewController *detailViewController = (SHScholarshipsDetailedViewController *)[segue destinationViewController];
        detailViewController.scholarship = object;
    }
    
    if ([segue.identifier isEqualToString:@"displayScholarshipsFavorites"]) {
        
        SHScholarshipsFavoritesTableViewController *scholarshipsFavoritesTableViewController = (SHScholarshipsFavoritesTableViewController *) [segue destinationViewController];
        
        scholarshipsFavoritesTableViewController.favoritesList = _favoritesList;
    }
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
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

@end
