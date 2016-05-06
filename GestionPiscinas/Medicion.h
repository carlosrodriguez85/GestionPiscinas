//
//  Medicion.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParametrosMedicion.h"

/*
 Esta clase podríamos utilizarla así:
 Medicion* medicion1 = [[Medicion alloc] initWithFecha:fechaMedicion];
 medicion1.parametros.PH = 5.5;
 */

@interface Medicion : NSObject<NSCoding> //tenemos que implementar el protocolo NSCoding, puesto que vamos a guardar mediciones en un plist

@property (nonatomic, strong) NSDate* fecha;
@property (nonatomic, strong) ParametrosMedicion* parametros;

-(instancetype)initWithFecha:(NSDate*)fecha;

@end
