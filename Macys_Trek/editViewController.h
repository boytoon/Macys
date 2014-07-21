//
//  editViewController.h
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/21/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"
#import <sqlite3.h>

@interface editViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtFieldName;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldRegPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldSalePrice;
@property (nonatomic) Products* editProduct;
@property (nonatomic) sqlite3* db;
- (IBAction)editProduct:(id)sender;
@end
