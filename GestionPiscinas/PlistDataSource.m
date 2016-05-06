//
//  PlistDataSource.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 28/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "PlistDataSource.h"

@interface PlistDataSource()

@end

@implementation PlistDataSource

static PlistDataSource* dataSource = nil;

-(instancetype)init
{
    self = [super init];
    if (self){
        
    }
    
    return self;
}

+(instancetype)sharedInstance
{
    if (dataSource == nil){
        dataSource = [[PlistDataSource alloc] init];
    }
    
    return dataSource;
}

-(Piscina *)agregarPiscina:(NSString *)nombre
{
    Piscina* piscina = [[Piscina alloc] initWithNombre:nombre];
    
    
    
    return piscina;
}

-(void)actualizarPiscina:(Piscina*)piscina
{
    
}

-(void)eliminarPiscina:(Piscina*)piscina
{
    
}

-(NSArray*)obtenerPiscinas
{
    
}

@end
