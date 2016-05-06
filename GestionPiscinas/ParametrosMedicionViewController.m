//
//  ParametrosMedicionViewController.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 12/4/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "ParametrosMedicionViewController.h"
#import "ParametrosMedicion.h"

@interface ParametrosMedicionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pHTextField;
@property (weak, nonatomic) IBOutlet UITextField *minDesinfectanteResidualTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxDesinfectanteResidualTextField;
@property (weak, nonatomic) IBOutlet UITextField *tiempoRecirculacionTextField;
@property (weak, nonatomic) IBOutlet UISwitch *turbidezSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *transparenciaSwitch;
@property (weak, nonatomic) IBOutlet UILabel *turbidezLabel;
@property (weak, nonatomic) IBOutlet UILabel *transparenciaLabel;
@end

@implementation ParametrosMedicionViewController

- (IBAction)turbidezWasTapped:(id)sender {
    if (self.turbidezSwitch.on == YES){
        self.turbidezLabel.text = @"Sí";
    }
    else{
        self.turbidezLabel.text = @"No";
    }
}

- (IBAction)transparenciaWasTapped:(id)sender {
    if (self.transparenciaSwitch.on == YES){
        self.transparenciaLabel.text = @"Sí";
    }
    else{
        self.transparenciaLabel.text = @"No";
    }
}

@end
