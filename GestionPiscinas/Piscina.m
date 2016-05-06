//
//  Piscina.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "Piscina.h"

@implementation Piscina

-(instancetype)initWithNombre:(NSString*)nombre
{
    self = [super init];
    if (self){
        self.nombre = nombre;
        self.mediciones = [[NSMutableArray alloc] init]; //mis mediciones son un conjunto vacío
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    //este método viene del protocolo NSCoding y tenemos que implementarlo de tal manera que se lea del aDecoder que nos pasan como parámetros todos los properties que se hayan guardado previamente mediante el "encodeWithCoder:" (sentido: DataSource->Repository->ViewController)
    self = [super init];
    if (self){
        self.nombre = [aDecoder decodeObjectForKey:@"nombre"];
        self.imagen = [aDecoder decodeObjectForKey:@"imagen"];
        self.mediciones = [aDecoder decodeObjectForKey:@"mediciones"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //este método viene del protocolo NSCoding y tenemos que implementarlo de tal manera que al objeto aCoder que nos dan como parámetro (el framework) le demos todos los properties de esta clase (sentido: ViewController->Repository->DataSource)
    [aCoder encodeObject:self.nombre forKey:@"nombre"];
    [aCoder encodeObject:self.imagen forKey:@"imagen"];
    [aCoder encodeObject:self.mediciones forKey:@"mediciones"];
}

@end
