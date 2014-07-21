//
//  editViewController.m
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/21/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
//

#import "editViewController.h"

@interface editViewController ()

@end

@implementation editViewController
@synthesize editProduct,txtFieldDescription,txtFieldName,txtFieldSalePrice,txtFieldRegPrice,db;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editProduct:(id)sender {
    Products * theProduct = [[Products alloc]init];
    theProduct.name = [self.txtFieldName text];
    theProduct.description = [self.txtFieldDescription text];
    theProduct.regularPrice = [self.txtFieldRegPrice.text doubleValue];
    theProduct.salePrice = [self.txtFieldSalePrice.text doubleValue];
    NSString * sql = [NSString stringWithFormat:@"UPDATE PRODUCTS SET name='%@',description='%@',regular_price='%f',sale_price='%f' where id='%i'",theProduct.name,theProduct.description,theProduct.regularPrice,theProduct.salePrice,self.editProduct.idProduct];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtFieldSalePrice resignFirstResponder];
    [self.txtFieldName resignFirstResponder];
    [self.txtFieldDescription resignFirstResponder];
    [self.txtFieldRegPrice resignFirstResponder];
}
@end
