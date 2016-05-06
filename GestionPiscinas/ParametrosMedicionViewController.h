//
//  ParametrosMedicionViewController.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 12/4/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Medicion.h"
#import "Piscina.h"

@interface ParametrosMedicionViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) Piscina* piscina;
@property (nonatomic, strong) Medicion* medicion;

@end
