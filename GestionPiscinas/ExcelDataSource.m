//
//  ExcelDataSource.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 13/5/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "ExcelDataSource.h"

@implementation ExcelDataSource

static ExcelDataSource* dataSource = nil;

+(instancetype)sharedInstance {
    if (dataSource == nil){
        dataSource = [[ExcelDataSource alloc] init];
    }
    
    return dataSource;
}

-(void)exportar:(NSArray<Piscina *>*)piscinas aFichero:(NSString *)nombreFichero
{
    
}

@end
