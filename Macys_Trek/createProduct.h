//
//  createProduct.h
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/21/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"
#import <sqlite3.h>

@interface createProduct : UIViewController

@property (nonatomic) sqlite3* db;

- (IBAction)addFirstProduct:(id)sender;
- (IBAction)addSecondProduct:(id)sender;

@end
