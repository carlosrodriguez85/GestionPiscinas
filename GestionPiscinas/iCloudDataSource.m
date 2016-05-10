//
//  iCloudDataSource.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 10/5/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "iCloudDataSource.h"

@implementation iCloudDataSource

static iCloudDataSource* dataSource = nil;

+(instancetype)sharedInstance
{
    if (dataSource == nil){
        dataSource = [[iCloudDataSource alloc] init];
    }
    
    return dataSource;
}

-(Piscina*)agregarPiscina:(NSString*)nombre
{
    Piscina* nuevaPiscina = [[Piscina alloc] initWithNombre:nombre];
    
    NSArray* piscinas = [self obtenerPiscinas];
    NSMutableArray* nuevasPiscinas = [[NSMutableArray alloc] initWithArray:piscinas];
    [nuevasPiscinas addObject:nuevaPiscina];
    
    //con NSUbiquitousKeyValueStore guardamos datos "sencillos" en la nube.
    
    //los métodos [set... forKey:] sirven para guardar en la nube contenidos.
    [[NSUbiquitousKeyValueStore defaultStore] setArray:nuevasPiscinas forKey:@"piscinas"];
    
    //realmente no se guarda nada en la nube hasta que no ejecutamos synchronize
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    
    return nuevaPiscina;
}

-(void)actualizarPiscina:(Piscina*)piscina
{
    //para actualizar una piscina, vamos a obtener el listado completo de piscinas, buscar el índice en el que estaba la antigua y volver a guardar el listado completo de nuevo dentro del fichero
    NSArray* piscinasLeidas = [self obtenerPiscinas];
    NSMutableArray* piscinas = [[NSMutableArray alloc] initWithArray:piscinasLeidas];
    
    NSInteger indice = 0;
    for (Piscina* p in piscinas){ //recorremos el listado de piscinas
        if ([p.nombre isEqualToString:piscina.nombre]){ //si la piscina actual tiene el mismo nombre que la piscina que queremos actualizar, terminamos el bucle. indice contiene el índice en el que está la piscina que queremos actualizar
            break;
        }
        indice++;
    }
    
    if (indice < piscinas.count){ //hemos encontrado una piscina, puesto que si indice >= piscinas.count, entonces es que la piscina a actualizar no estaba en el array
        [piscinas replaceObjectAtIndex:indice withObject:piscina];
        
        //guardamos el listado actualizado de piscinas en la nube
        [[NSUbiquitousKeyValueStore defaultStore] setArray:piscinas forKey:@"piscinas"];
        [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    }
}

-(void)eliminarPiscina:(Piscina*)piscina
{
    //para eliminar una piscina, vamos a obtener el listado completo de piscinas, buscar el índice en el que esta la piscina, eliminar la piscina del array y volver a guardar el listado completo de nuevo dentro del fichero
    NSArray* piscinasLeidas = [self obtenerPiscinas];
    NSMutableArray* piscinas = [[NSMutableArray alloc] initWithArray:piscinasLeidas];
    
    NSInteger indice = 0;
    for (Piscina* p in piscinas){ //recorremos el listado de piscinas
        if ([p.nombre isEqualToString:piscina.nombre]){ //si la piscina actual tiene el mismo nombre que la piscina que queremos eliminar, terminamos el bucle. indice contiene el índice en el que está la piscina que queremos eliminar
            break;
        }
        indice++;
    }
    
    if (indice < piscinas.count){ //hemos encontrado una piscina, puesto que si indice >= piscinas.count, entonces es que la piscina a eliminar no estaba en el array
        [piscinas removeObjectAtIndex:indice];
        
        //guardamos el listado actualizado de piscinas en la nube
        [[NSUbiquitousKeyValueStore defaultStore] setArray:piscinas forKey:@"piscinas"];
        [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    }
}

-(NSArray*)obtenerPiscinas
{
    NSArray* piscinas = [[NSUbiquitousKeyValueStore defaultStore] arrayForKey:@"piscinas"];
    
    //la primera vez que pedimos las piscinas, puede que no haya nada en la nube
    if (piscinas == nil){
        return [[NSArray alloc] init];
    }
    else{
        return piscinas;
    }
}

@end
