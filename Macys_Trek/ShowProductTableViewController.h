//
//  ShowProductTableViewController.h
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/19/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
/**Purpose:
*/
#import <UIKit/UIKit.h>
#import "productDetail.h"
#import "Products.h"
#import <sqlite3.h>

@interface ShowProductTableViewController : UITableViewController

@property (nonatomic,retain) NSArray* arrayProduct;
@property (nonatomic) sqlite3* db;

- (NSMutableArray *) productList;

@end
