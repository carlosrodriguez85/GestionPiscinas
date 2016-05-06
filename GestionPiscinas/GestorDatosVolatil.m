//
//  GestorDatosVolatil.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "GestorDatosVolatil.h"

@implementation GestorDatosVolatil

static NSMutableArray* piscinas = nil;

+(Piscina *)agregarPiscina:(NSString *)nombre
{
    Piscina* piscina = [[Piscina alloc] initWithNombre:nombre];
    
    if (piscinas == nil){
        piscinas = [[NSMutableArray alloc] init];
    }
    
    [piscinas addObject:piscina];
    
    return piscina;
}

+(void)actualizarPiscina:(Piscina*)piscina
{
    NSInteger indexPiscina = [piscinas indexOfObject:piscina]; //esto me da el index de la piscina en el array
    [piscinas replaceObjectAtIndex:indexPiscina withObject:piscina];
}

+(void)eliminarPiscina:(Piscina*)piscina
{
    [piscinas removeObject:piscina];
}

+(NSArray*)obtenerPiscinas
{
    return piscinas;
}

@end
