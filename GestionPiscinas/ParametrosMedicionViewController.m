//
//  ParametrosMedicionViewController.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 12/4/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "ParametrosMedicionViewController.h"
#import "ParametrosMedicion.h"
#import "Repository.h"

@interface ParametrosMedicionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pHTextField;
@property (weak, nonatomic) IBOutlet UITextField *minDesinfectanteResidualTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxDesinfectanteResidualTextField;
@property (weak, nonatomic) IBOutlet UITextField *tiempoRecirculacionTextField;
@property (weak, nonatomic) IBOutlet UISwitch *turbidezSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *transparenciaSwitch;
@property (weak, nonatomic) IBOutlet UILabel *turbidezLabel;
@property (weak, nonatomic) IBOutlet UILabel *transparenciaLabel;
@property (weak, nonatomic) IBOutlet UITextView *comentarioTextView;
@end

@implementation ParametrosMedicionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSDateFormatter localizedStringFromDate:self.medicion.fecha dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle]; //con self.title cambiamos el titulo que aparece arriba en el NavigationController.
    
    //self.pHTextField.delegate = self; esto sería con todos los textfields, pero esta hecho en el storyboard.
    
    self.pHTextField.text = [NSString stringWithFormat:@"%.1f", self.medicion.parametros.pH];
    self.minDesinfectanteResidualTextField.text = [NSString stringWithFormat:@"%.1f", self.medicion.parametros.desinfectanteResidual];
    self.maxDesinfectanteResidualTextField.text = [NSString stringWithFormat:@"%.1f", self.medicion.parametros.desinfectanteLibre];
    self.tiempoRecirculacionTextField.text = [NSString stringWithFormat:@"%.1f", self.medicion.parametros.tiempoRecirculacion];
    self.turbidezSwitch.on = self.medicion.parametros.turbidez;
    self.transparenciaSwitch.on = self.medicion.parametros.transparencia;
    
    if (self.turbidezSwitch.on == YES){
        self.turbidezLabel.text = @"Sí";
    }
    else{
        self.turbidezLabel.text = @"No";
    }
    
    if (self.transparenciaSwitch.on == YES){
        self.transparenciaLabel.text = @"Sí";
    }
    else{
        self.transparenciaLabel.text = @"No";
    }
    
    self.comentarioTextView.text = self.medicion.parametros.comentario;
}

//este método se puede sobrecargar para ejecutar las operaciones que deseemos cuando el usuario pulse en el botón de atrás.
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //metemos en el modelo los contenidos de los textfields. El objetivo es evitar que el usuario no le dé a intro y no se guarden los datos.
    self.medicion.parametros.pH = [self.pHTextField.text floatValue];
    self.medicion.parametros.desinfectanteResidual = [self.minDesinfectanteResidualTextField.text floatValue];
    self.medicion.parametros.desinfectanteLibre = [self.maxDesinfectanteResidualTextField.text floatValue];
    self.medicion.parametros.tiempoRecirculacion = [self.tiempoRecirculacionTextField.text floatValue];
    
    //metemos en el modelo el comentario que se haya escrito para que no se pierda
    self.medicion.parametros.comentario = self.comentarioTextView.text;
    
    //actualizamos la piscina, con el proposito de que se guarde el comentario
    [[Repository sharedInstance] actualizarPiscina:self.piscina];
}

- (IBAction)turbidezWasTapped:(id)sender {
    if (self.turbidezSwitch.on == YES){
        self.turbidezLabel.text = @"Sí";
        self.medicion.parametros.turbidez = YES;
    }
    else{
        self.turbidezLabel.text = @"No";
        self.medicion.parametros.turbidez = NO;
    }
    
    //no hace falta actualizar el repositorio aquí, puesto que se va a actualizar al darle al botón de atrás. Hemos implementado el método viewWillDisappear con esta línea.
    //[[Repository sharedInstance] actualizarPiscina:self.piscina];
}

- (IBAction)transparenciaWasTapped:(id)sender {
    if (self.transparenciaSwitch.on == YES){
        self.transparenciaLabel.text = @"Sí";
        self.medicion.parametros.transparencia = YES;
    }
    else{
        self.transparenciaLabel.text = @"No";
        self.medicion.parametros.transparencia = NO;
    }
    
    //no hace falta actualizar el repositorio aquí, puesto que se va a actualizar al darle al botón de atrás. Hemos implementado el método viewWillDisappear con esta línea.
    //[[Repository sharedInstance] actualizarPiscina:self.piscina];
}

#pragma mark - UITextField delegate

//estamos convirtiendo lo introducido en los textfield a los tipos de los properties de la clase ParametrosMedicion
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder]; //oculta el teclado
    
    //estas líneas no son necesarias, puesto que en el viewWillDisappear ya guardamos los contenidos de todos los textfields en el modelo siempre que se le dé al botón atrás.
    /*
    if (textField == self.pHTextField){
        self.medicion.parametros.pH = [textField.text floatValue];
    }
    else if (textField == self.minDesinfectanteResidualTextField){
        self.medicion.parametros.desinfectanteResidual = [textField.text floatValue];
    }
    else if (textField == self.maxDesinfectanteResidualTextField){
        self.medicion.parametros.desinfectanteLibre = [textField.text floatValue];
    }
    else if (textField == self.tiempoRecirculacionTextField){
        self.medicion.parametros.tiempoRecirculacion = [textField.text floatValue];
    }*/
    
    //no hace falta actualizar el repositorio aquí, puesto que se va a actualizar al darle al botón de atrás. Hemos implementado el método viewWillDisappear con esta línea.
    //[[Repository sharedInstance] actualizarPiscina:self.piscina];
    
    return YES;
}

@end
