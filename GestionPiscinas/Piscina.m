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

@end
