//
//  GestorDatos.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

@import Foundation;
#import "Piscina.h"
#import "Medicion.h"
#import "ParametrosMedicion.h"

@protocol GestorDatos <NSObject>

+(Piscina*)agregarPiscina:(NSString*)nombre;
+(void)actualizarPiscina:(Piscina*)piscina;
+(void)eliminarPiscina:(Piscina*)piscina;
+(NSArray*)obtenerPiscinas;

@end

