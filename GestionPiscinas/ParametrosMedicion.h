//
//  ParametrosMedicion.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParametrosMedicion : NSObject

@property (nonatomic, assign) float PH;
@property (nonatomic, assign) float cloroResidual;
@property (nonatomic, assign) float cloroLibre;
@property (nonatomic, assign) BOOL turbidez;
@property (nonatomic, assign) BOOL otro;

@end
