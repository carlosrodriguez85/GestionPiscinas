//
//  ParametrosMedicion.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParametrosMedicion : NSObject<NSCoding> //tenemos que implementar el protocolo NSCoding, puesto que vamos a guardar parametros de medición en un plist

@property (nonatomic, assign) float pH;
@property (nonatomic, assign) float desinfectanteResidual;
@property (nonatomic, assign) float desinfectanteLibre;
@property (nonatomic, assign) float tiempoRecirculacion;
@property (nonatomic, assign) BOOL turbidez;
@property (nonatomic, assign) BOOL transparencia;
@property (nonatomic, strong) NSString* comentario;

@end
