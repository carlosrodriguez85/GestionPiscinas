//
//  ExcelDataSource.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 13/5/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "ExcelDataSource.h"
#import "BRAOfficeDocumentPackage.h"
#import "Medicion.h"

@implementation ExcelDataSource

static ExcelDataSource* dataSource = nil;

+(instancetype)sharedInstance {
    if (dataSource == nil){
        dataSource = [[ExcelDataSource alloc] init];
    }
    
    return dataSource;
}

-(NSString*)exportar:(NSArray<Piscina *>*)piscinas aFichero:(NSString *)nombreFichero
{
    //esta línea que hay a continuación permite obtener el path a cualquier fichero que haya dentro de nuestro "Contents".
    NSString* pathLibroVacio = [[NSBundle mainBundle] pathForResource:@"libroVacio" ofType:@"xlsx"];
    
    BRAOfficeDocumentPackage* ficheroXlsx = [BRAOfficeDocumentPackage open:pathLibroVacio];
    BRAOfficeDocument* documento = ficheroXlsx.workbook;
    BRAWorksheet* hojaReferencia = [documento worksheetNamed:@"Hoja1"];
    
    for (Piscina* piscina in piscinas){
        BRAWorksheet* hoja = [documento createWorksheetNamed:piscina.nombre byCopyingWorksheet:hojaReferencia];
        
        //aquí falta el código para meter los datos de las mediciones dentro del excel
        for (NSInteger fila = 0; fila < piscina.mediciones.count; fila++){
            Medicion* medicion = [piscina.mediciones objectAtIndex:fila];
            [self escribirMedicion:medicion enFila:fila hoja:hoja];
        }
    }
    
    //eliminamos la primera pestaña, puesto que nos viene dada por el fichero libroVacio.xlsx
    [documento removeWorksheetNamed:@"Hoja1"];
    
    NSLog(@"%@", nombreFichero);
    
    //al guardar, guardamos en el path que nos hayan pasado como parámetro (normalmente el path estará dentro de la carpeta Documents)
    [ficheroXlsx saveAs:nombreFichero];
    
    return nombreFichero;
}

-(void)escribirMedicion:(Medicion*)medicion enFila:(NSInteger)fila hoja:(BRAWorksheet*)hoja
{
    //siempre tenemos que sumar cuatro a la fila, puesto que las tres primeras filas las ocupan la cabecera
    NSInteger filaReal = fila+4;
    
    //obtenemos una referencia a la primera celda para escribir la fecha de medición
    
    //ojo!! las filas y las columnas comienzan por el índice 1
    NSString* referenciaCelda = [BRACell cellReferenceForColumnIndex:1 andRowIndex:filaReal];
    [[hoja cellForCellReference:referenciaCelda shouldCreate:YES] setDateValue:medicion.fecha];
    [[hoja cellForCellReference:referenciaCelda] setNumberFormat:@"d/m"];
    
    //obtenemos una referencia a la segunda celda para escribir la hora de medición
    referenciaCelda = [BRACell cellReferenceForColumnIndex:2 andRowIndex:filaReal];
    NSString* valorHora = [NSDateFormatter localizedStringFromDate:medicion.fecha dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    [[hoja cellForCellReference:referenciaCelda shouldCreate:YES] setStringValue:valorHora];
    
    //obtenemos una referencia a la tercera celda para escribir el pH
    referenciaCelda = [BRACell cellReferenceForColumnIndex:3 andRowIndex:filaReal];
    [[hoja cellForCellReference:referenciaCelda shouldCreate:YES] setFloatValue:medicion.parametros.pH];
    
    //obtenemos una referencia a la cuarta celda para escribir el des. residual
    referenciaCelda = [BRACell cellReferenceForColumnIndex:4 andRowIndex:filaReal];
    NSString* desinfectanteResidual = [NSString stringWithFormat:@"%.1f/%.1f", medicion.parametros.desinfectanteResidual, medicion.parametros.desinfectanteLibre];
    [[hoja cellForCellReference:referenciaCelda shouldCreate:YES] setStringValue:desinfectanteResidual];
    
    //obtenemos una referencia a la quinta celda para escribir la turbidez
    referenciaCelda = [BRACell cellReferenceForColumnIndex:5 andRowIndex:filaReal];
    [[hoja cellForCellReference:referenciaCelda shouldCreate:YES] setStringValue:(medicion.parametros.turbidez ? @"SI" : @"NO")];
    
    //obtenemos una referencia a la sexta celda para escribir la transparencia
    referenciaCelda = [BRACell cellReferenceForColumnIndex:6 andRowIndex:filaReal];
    [[hoja cellForCellReference:referenciaCelda shouldCreate:YES] setStringValue:(medicion.parametros.transparencia ? @"SI" : @"NO")];
    
    //obtenemos una referencia a la octava celda para escribir el tiempo de recirculación
    referenciaCelda = [BRACell cellReferenceForColumnIndex:8 andRowIndex:filaReal];
    [[hoja cellForCellReference:referenciaCelda shouldCreate:YES] setFloatValue:medicion.parametros.tiempoRecirculacion];
    
    //obtenemos una referencia a la treceava celda para escribir el comentario
    referenciaCelda = [BRACell cellReferenceForColumnIndex:13 andRowIndex:filaReal];
    [[hoja cellForCellReference:referenciaCelda shouldCreate:YES] setStringValue:medicion.parametros.comentario];
}

@end
