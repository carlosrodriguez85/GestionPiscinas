//
//  ParametrosMedicion.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "ParametrosMedicion.h"

@implementation ParametrosMedicion

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.pH = [aDecoder decodeFloatForKey:@"pH"];
        self.desinfectanteResidual = [aDecoder decodeFloatForKey:@"desinfectanteResidual"];
        self.desinfectanteLibre = [aDecoder decodeFloatForKey:@"desinfectanteLibre"];
        self.tiempoRecirculacion = [aDecoder decodeFloatForKey:@"tiempoRecirculacion"];
        self.turbidez = [aDecoder decodeBoolForKey:@"turbidez"];
        self.transparencia = [aDecoder decodeBoolForKey:@"transparencia"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeFloat:self.pH forKey:@"pH"];
    [aCoder encodeFloat:self.desinfectanteResidual forKey:@"desinfectanteResidual"];
    [aCoder encodeFloat:self.desinfectanteLibre forKey:@"desinfectanteLibre"];
    [aCoder encodeFloat:self.tiempoRecirculacion forKey:@"tiempoRecirculacion"];
    [aCoder encodeBool:self.turbidez forKey:@"turbidez"];
    [aCoder encodeBool:self.transparencia forKey:@"transparencia"];
}

@end
