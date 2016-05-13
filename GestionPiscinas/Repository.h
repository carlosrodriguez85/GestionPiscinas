//
//  Repository.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 17/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piscina.h"

@interface Repository : NSObject

+(Repository*) sharedInstance; //Diferentes nombres que podría tener: sharedRepository, defaultRepository, singleton, etc.

-(Piscina*)agregarPiscina:(NSString*)nombre;
-(void)actualizarPiscina:(Piscina*)piscina;
-(void)eliminarPiscina:(Piscina*)piscina;
-(NSArray*)obtenerPiscinas;
-(void)exportar;

@end
