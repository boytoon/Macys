//
//  createProduct.m
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/21/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
//

#import "createProduct.h"

@interface createProduct ()

@end

@implementation createProduct
@synthesize db;
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

- (IBAction)addFirstProduct:(id)sender {
    //Products * theProduct = [[Products alloc]init];
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO PRODUCTS (NAME,DESCRIPTION,REGULAR_PRICE, SALE_PRICE) VALUES ('A&C','Awesome Jackets and Pants','200.00','49.99')"];
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

- (IBAction)addSecondProduct:(id)sender {
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO PRODUCTS (NAME,DESCRIPTION,REGULAR_PRICE, SALE_PRICE) VALUES ('E&F','Awesome T-shirts and Jeans','560.00','99.99')"];
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
            if (sqlite3_step(sqlStatement)==SQLITE_DONE) {
                NSLog(@"DB updated");
            }
        }
        else{
            NSLog(@"it's not IN");
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
