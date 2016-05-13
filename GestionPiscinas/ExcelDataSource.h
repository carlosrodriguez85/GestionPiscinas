//
//  ExcelDataSource.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 13/5/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piscina.h"

@interface ExcelDataSource : NSObject

+(instancetype)sharedInstance;

-(void)exportar:(NSArray<Piscina*>*)piscinas aFichero:(NSString*)nombreFichero;

@end
