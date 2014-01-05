//
//  WIWMasterViewController.m
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import "WIWMasterViewController.h"
#import "WIWDetailViewController.h"

#import "WIWConnections.h"
#import "WIWStaff.h"
#import "MBProgressHUD.h"


@interface WIWMasterViewController () {
    NSMutableArray *_objects;
}
/// The HUD element to show over the table
@property (nonatomic, strong) MBProgressHUD* HUD;
/// The refresh control of the table
@property (nonatomic, strong) UIRefreshControl* refreshControl;
/// flag to know is there is a on going call to the server
@property (nonatomic) BOOL loading;

@end

@implementation WIWMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
     
     UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
     self.navigationItem.rightBarButtonItem = addButton;
     */
    
    self.loading=NO;
    
    // add a push to refresh
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    
    [self.refreshControl beginRefreshing];
    [self pullToRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
*/
#pragma mark - Reload the data
/*!
 *\brief This method set a HUD to block the interface for user touches and show a spinning wheel with a loading legend
 * This method show a HUD to block the interface for user touches and show a spinning wheel with a loading legend and also
 * show a spinning wheel on the upper zone of the table with another spinning wheel and the date of the last refreshing
 *\return void
*/
- (void)pullToRefresh
{
    if(!self.loading){
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.labelText = @"Loading";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.loading=YES;
            
            //set the title while refreshing
            self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing the Data"];
            //set the date and time of refreshing
            NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
            [formattedDate setDateFormat:@"MMM d, h:mm a"];
            NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastupdated attributes:@{ NSForegroundColorAttributeName: [UIColor colorWithRed:0.5255 green:0.5294 blue:0.5273 alpha:1]}];
            //end the refreshing
            
            [self.tableView setScrollsToTop:YES];
            
            [self reloadDataFromServer];
            
        });
    }
}
/*!
 *\brief This method ask the server for data and in the response reload the data of the table.
 *
 *\return void
*/
-(void)reloadDataFromServer{
    
    [[WIWConnections sharedInstance] connectToServerWithSuccessBlock:^(NSMutableArray *array) {
        _objects=array;
        [self.tableView reloadData];
        [self endCommunicationWithServer];
        [self loadElementIfJustOne:_objects];
    } andErrorBlock:^(NSError *error) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This is embarrassing but there is an error and the info is unreachable at this moment" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        NSLog(@"Error %@",error);
        [self endCommunicationWithServer];
    }];
}
/*!
 *\brief This method must be called after each communication with the server
 * Inside this method the flags that allow just one communication at a time with the server are reset and the HUD are removed
 *\return void
*/
-(void)endCommunicationWithServer{
    [self.HUD removeFromSuperview];
    self.HUD = nil;
    self.loading=NO;
    [self.refreshControl endRefreshing];

}
/*!
 *\brief Check if there is just one element and if that happends load the element on the detail view
 *
 *\param objects an \c NSArray with the objects
 *\return 
*/
-(void)loadElementIfJustOne:(NSArray*)objects{
//Check if there is just one element
if (objects.count==1) {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    WIWStaff *object = _objects[indexPath.row];
    cell.textLabel.text = [object name];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WIWStaff *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
