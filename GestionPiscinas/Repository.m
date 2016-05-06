//
//  Repository.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 17/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "Repository.h"
#import "LocalMemoryDataSource.h"

@implementation Repository

//en swift: class var repository = Repository()

static Repository* repository = nil;

+(Repository*) sharedInstance
{
    //ESTO NO DEBERÍA HACERSE, PUESTO QUE SI NO SE CREARÍAN DIFERENTES OBJETOS CADA VEZ QUE SE LLAMASE A ESTE MÉTODO:
    // Repository* resultado = [[Repository alloc] init];
    // return resultado;
    
    if (repository == nil) {
        repository = [[Repository alloc] init];
    }
    
    return repository;
}

-(Piscina*)agregarPiscina:(NSString*)nombre
{
    Piscina* nuevaPiscina = [[LocalMemoryDataSource sharedInstance] agregarPiscina:nombre];
    
    return nuevaPiscina;
}

-(void)actualizarPiscina:(Piscina*)piscina
{
    [[LocalMemoryDataSource sharedInstance] actualizarPiscina:piscina];
}

-(void)eliminarPiscina:(Piscina*)piscina
{
    [[LocalMemoryDataSource sharedInstance] eliminarPiscina:piscina];
}

-(NSArray*)obtenerPiscinas
{
    NSArray* piscinas = [[LocalMemoryDataSource sharedInstance] obtenerPiscinas];
    
    return piscinas;
}

@end
