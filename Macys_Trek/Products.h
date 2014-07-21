//
//  Products.h
//  Macys_Trek
//
//  Created by Pichit Laokankana on 7/19/14.
//  Copyright (c) 2014 Pichit Laokanjana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface Products : NSObject
{
    sqlite3* _database;
}
//@property (nonatomic) sqlite3* databaseConnection;
@property (nonatomic) int idProduct;
@property (nonatomic) NSString*name;
@property (nonatomic) NSString*description;
@property (nonatomic) double regularPrice;
@property (nonatomic) double salePrice;
@property (nonatomic) UIImage*image;
@property (nonatomic) NSArray*colors;
@property (nonatomic) NSDictionary*store;

@end
