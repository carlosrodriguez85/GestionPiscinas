//
//  ExcelDataSource.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 13/5/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "ExcelDataSource.h"
#import "BRAOfficeDocumentPackage.h"

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
    BRAOfficeDocumentPackage* ficheroXlsx = [BRAOfficeDocumentPackage create:nombreFichero];
    BRAOfficeDocument* documento = ficheroXlsx.workbook;
    for (Piscina* piscina in piscinas){
        BRAWorksheet* hoja = [documento createWorksheetNamed:piscina.nombre];
        
        //aquí falta el código para meter los datos de las mediciones dentro del excel
    }
    
    NSLog(@"%@", nombreFichero);
    
    [ficheroXlsx save];
}

@end
