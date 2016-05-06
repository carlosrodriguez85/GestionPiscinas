//
//  MedicionesViewController.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Piscina.h"

@interface MedicionesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Piscina* piscina;

@end
