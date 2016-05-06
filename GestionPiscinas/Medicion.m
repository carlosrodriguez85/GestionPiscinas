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
        self.parametros = [[ParametrosMedicion alloc] init];
    }
    
    return self;
}

@end
