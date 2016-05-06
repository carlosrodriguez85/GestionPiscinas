//
//  Medicion.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "Medicion.h"

@implementation Medicion

-(instancetype)initWithFecha:(NSDate *)fecha
{
    self = [super init];
    if (self){
        self.fecha = fecha;
        self.parametros = [[ParametrosMedicion alloc] init];//cuando creo una medición, aún no he metido los parámetros, por tanto será un objeto de parámetros "vacío"
    }
    
    return self;
}

@end
