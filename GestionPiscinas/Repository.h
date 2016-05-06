//
//  Repository.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 17/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repository : NSObject

+(Repository*) sharedInstance; //sharedRepository, defaultRepository, singleton, etc.

@end
