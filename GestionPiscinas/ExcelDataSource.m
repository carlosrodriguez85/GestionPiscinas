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
    //esta línea que hay a continuación permite obtener el path a cualquier fichero que haya dentro de nuestro "Contents".
    NSString* pathLibroVacio = [[NSBundle mainBundle] pathForResource:@"libroVacio" ofType:@"xlsx"];
    
    BRAOfficeDocumentPackage* ficheroXlsx = [BRAOfficeDocumentPackage open:pathLibroVacio];
    BRAOfficeDocument* documento = ficheroXlsx.workbook;
    BRAWorksheet* hojaReferencia = [documento worksheetNamed:@"Hoja1"];
    for (Piscina* piscina in piscinas){
        BRAWorksheet* hoja = [documento createWorksheetNamed:piscina.nombre byCopyingWorksheet:hojaReferencia];
        
        //aquí falta el código para meter los datos de las mediciones dentro del excel
    }
    
    //eliminamos la primera pestaña, puesto que nos viene dada por el fichero libroVacio.xlsx
    [documento removeWorksheetNamed:@"Hoja1"];
    
    NSLog(@"%@", nombreFichero);
    
    //al guardar, guardamos en el path que nos hayan pasado como parámetro (normalmente el path estará dentro de la carpeta Documents)
    [ficheroXlsx saveAs:nombreFichero];
}

@end
