//
//  Piscina.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit; //esto es para poder utilizar UIImage

@interface Piscina : NSObject

@property (nonatomic, strong) NSString* nombre;
@property (nonatomic, strong) UIImage* imagen;
@property (nonatomic, strong) NSMutableArray* mediciones;

-(instancetype)initWithNombre:(NSString*)nombre;

@end
