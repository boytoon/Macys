//
//  ShowProductTableViewController.m
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/19/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
//

#import "ShowProductTableViewController.h"

@interface ShowProductTableViewController ()

@end

@implementation ShowProductTableViewController

@synthesize arrayProduct,db;

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
    arrayProduct = [self productList];
    [super viewDidLoad];
    //self.arrayProduct = [[Products database]productDetail];
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.arrayProduct count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    Products * productIndex = [self.arrayProduct objectAtIndex:indexPath.row];
    cell.textLabel.text = productIndex.name;
    // Configure the cell...
    
    return cell;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"productDetail"])
    {
        productDetail* detailViewController = [segue destinationViewController];
        detailViewController.products = [self.arrayProduct objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



- (NSMutableArray *) productList
{
    NSMutableArray * products = [[NSMutableArray alloc]init];
    @try {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"products.db"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot Locate db file %@",dbPath);
        }
        if(!sqlite3_open([dbPath UTF8String], &db))
        {
            NSLog(@"cannot open db %s", sqlite3_errmsg(db));
        }
            
        const char *sql = "Select * from products";
        sqlite3_stmt * sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                Products * pd = [[Products alloc]init];
                pd.idProduct = sqlite3_column_int(sqlStatement, 0);
                pd.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStatement, 1)];
                pd.description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStatement, 2)];
                pd.regularPrice = sqlite3_column_double(sqlStatement, 3);
                pd.salePrice = sqlite3_column_double(sqlStatement, 4);
                [products addObject:pd];
            }
        }
        else{

        }
    }
    @catch (NSException *exception) {

    }
    @finally {
        sqlite3_close(db);
        return products;
    }
}

@end
