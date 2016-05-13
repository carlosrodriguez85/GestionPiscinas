//
//  PiscinasViewController.h
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@import QuickLook; //esto nos permite mostrar ficheros directamente en el iphone

@interface PiscinasViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, QLPreviewControllerDataSource> //el último datasource se incorpora para poder previsualizar ficheros en el iphone

@end
