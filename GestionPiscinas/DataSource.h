//
//  DataSource.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

@import Foundation;
#import "Piscina.h"
#import "Medicion.h"
#import "ParametrosMedicion.h"

@protocol DataSource <NSObject>

+(instancetype)sharedInstance; //esto devolvera un objeto de la clase que implemente el DataSource, y como no sabemos el nombre de dicha clase (o habrá varias clases posibles, eg. DBDataSource, iCloudDataSource, PlistDataSource), entonces ponemos instancetype.

-(Piscina*)agregarPiscina:(NSString*)nombre;
-(void)actualizarPiscina:(Piscina*)piscina;
-(void)eliminarPiscina:(Piscina*)piscina;
-(NSArray*)obtenerPiscinas;

@end

