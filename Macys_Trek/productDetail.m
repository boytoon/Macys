//
//  productDetail.m
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/20/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
//

#import "productDetail.h"

@interface productDetail ()

@end

@implementation productDetail
@synthesize products,db,txtName,txtDescription,txtRegPrice,txtSalePrice,imageBt;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.txtName.text = self.products.name;
    self.txtDescription.text = self.products.description;
    self.txtRegPrice.text = [NSString stringWithFormat:@"%f",self.products.regularPrice];
    self.txtSalePrice.text = [NSString stringWithFormat:@"%f",self.products.salePrice];
    /*UIImage * imageBlueShirt = [UIImage imageNamed:@"blue_Tshirt.jpg"];
    CGSize destinationSize = CGSizeMake(275,141);
    UIGraphicsBeginImageContext(destinationSize);
    [imageBlueShirt drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [productImage setImage:newImage];*/
    self.imageBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageBt.frame = CGRectMake(100.0, 100.0, 57.0, 57.0);
    [imageBt setImage:[UIImage imageNamed:@"blue_Tshirt.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:imageBt];

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"editDetail"])
    {
        editViewController* editViewController = [segue destinationViewController];
        editViewController.editProduct = self.products;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)deleteProducts:(id)sender {
    NSString * sql = [NSString stringWithFormat:@"DELETE FROM PRODUCTS WHERE ID='%i'",products.idProduct];
    NSLog(@"update = %@",sql);
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
        
        sqlite3_stmt * sqlStatement;
        if(sqlite3_prepare(db, [sql UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            NSLog(@"it is in here");
            if (sqlite3_step(sqlStatement)==SQLITE_DONE) {
                NSLog(@"DB updated");
            }
        }
        else{
            NSLog(@"it's not");
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with statement");
    }
    @finally {
        sqlite3_close(db);
    }
}

@end
