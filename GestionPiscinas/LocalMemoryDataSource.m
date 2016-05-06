//
//  GestorDatosVolatil.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "LocalMemoryDataSource.h"

@interface LocalMemoryDataSource()

@property (nonatomic, strong) NSMutableArray* piscinas;

@end

@implementation LocalMemoryDataSource //aún falta por implementar el sharedInstance

-(instancetype)init
{
    self = [super init];
    if (self){
        self.piscinas = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(Piscina *)agregarPiscina:(NSString *)nombre
{
    Piscina* piscina = [[Piscina alloc] initWithNombre:nombre];
    
    [self.piscinas addObject:piscina];
    
    return piscina;
}

-(void)actualizarPiscina:(Piscina*)piscina
{
    NSInteger indexPiscina = [self.piscinas indexOfObject:piscina]; //esto me da el index de la piscina en el array
    [self.piscinas replaceObjectAtIndex:indexPiscina withObject:piscina];
}

-(void)eliminarPiscina:(Piscina*)piscina
{
    [self.piscinas removeObject:piscina];
}

-(NSArray*)obtenerPiscinas
{
    return self.piscinas;
}

@end
