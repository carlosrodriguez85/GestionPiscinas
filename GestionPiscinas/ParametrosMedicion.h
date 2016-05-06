//
//  ParametrosMedicion.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParametrosMedicion : NSObject

@property (nonatomic, assign) float pH;
@property (nonatomic, assign) float desinfectanteResidual;
@property (nonatomic, assign) float desinfectanteLibre;
@property (nonatomic, assign) BOOL turbidez;
@property (nonatomic, assign) BOOL transparencia;

@end
