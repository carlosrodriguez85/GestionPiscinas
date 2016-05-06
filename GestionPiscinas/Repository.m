//
//  Repository.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 17/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "Repository.h"
#import "LocalMemoryDataSource.h"
#import "PlistDataSource.h" //añadimos el datasource, para que entienda el repositorio que hay PlistDataSources

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
    [[PlistDataSource sharedInstance] agregarPiscina:nombre];
    
    return nuevaPiscina;
}

-(void)actualizarPiscina:(Piscina*)piscina
{
    [[LocalMemoryDataSource sharedInstance] actualizarPiscina:piscina];
    [[PlistDataSource sharedInstance] actualizarPiscina:piscina];
}

-(void)eliminarPiscina:(Piscina*)piscina
{
    [[LocalMemoryDataSource sharedInstance] eliminarPiscina:piscina];
    [[PlistDataSource sharedInstance] eliminarPiscina:piscina];
}

-(NSArray*)obtenerPiscinas
{
    NSArray* piscinas = [[LocalMemoryDataSource sharedInstance] obtenerPiscinas];// lee de memoria primero, y si no hay nada en memoria, entonces lo lee del fichero.
    if (piscinas.count == 0){ //no hay nada en memoria
        piscinas = [[PlistDataSource sharedInstance] obtenerPiscinas]; //tomar del plist
        [[LocalMemoryDataSource sharedInstance] sustituirPiscinas:piscinas]; //esto sincroniza lo que hay en disco con lo que hay en memoria (que siempre que se inicia la aplicación está siempre vacío)
    }
    
    return piscinas;
}

@end
