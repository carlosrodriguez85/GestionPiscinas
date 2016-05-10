//
//  iCloudDataSource.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 10/5/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"

@interface iCloudDataSource : NSObject<DataSource>

-(void)sustituirPiscinas:(NSArray*)piscinas; //reemplazamos todas las piscinas que haya en memoria por las que nos pasen en el array (el parámetro piscinas)

@end
