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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    //este método viene del protocolo NSCoding y tenemos que implementarlo de tal manera que se lea del aDecoder que nos pasan como parámetros todos los properties que se hayan guardado previamente mediante el "encodeWithCoder:" (sentido: DataSource->Repository->ViewController)
    self = [super init];
    if (self) {
        self.fecha = [coder decodeObjectForKey:@"fecha"];
        self.parametros = [coder decodeObjectForKey:@"parametros"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    //este método viene del protocolo NSCoding y tenemos que implementarlo de tal manera que al objeto aCoder que nos dan como parámetro (el framework) le demos todos los properties de esta clase (sentido: ViewController->Repository->DataSource)
    [coder encodeObject:self.fecha forKey:@"fecha"];
    [coder encodeObject:self.parametros forKey:@"parametros"];
}

@end
