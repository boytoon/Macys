//
//  productDetail.h
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/20/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"
#import "editViewController.h"
#import "imageView.h"
@interface productDetail : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *imageBt;
@property (weak, nonatomic) IBOutlet UITextView *txtName;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;

@property (weak, nonatomic) IBOutlet UITextView *txtRegPrice;
@property (nonatomic,strong) Products* products;
@property (weak, nonatomic) IBOutlet UITextView *txtSalePrice;
@property (nonatomic) sqlite3* db;
- (IBAction)deleteProducts:(id)sender;

@end
