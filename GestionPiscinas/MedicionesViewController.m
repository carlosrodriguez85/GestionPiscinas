//
//  MedicionesViewController.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "MedicionesViewController.h"
#import "Medicion.h"
#import "Repository.h"
#import "ParametrosMedicionViewController.h"

@interface MedicionesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MedicionesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.piscina.nombre; //con self.title cambiamos el titulo que aparece arriba en el NavigationController.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView datasource & delegate
//El delegate y el datasource estan relacionados por storyboard, no por código

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.piscina.mediciones.count; //hay tantas filas como mediciones en la piscina
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CeldaMedicion" forIndexPath:indexPath];
    Medicion* medicion = [self.piscina.mediciones objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSDateFormatter localizedStringFromDate:medicion.fecha dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterShortStyle];
    
    return cell;
}

//este método es el que hay que implementar si queremos que aparezca el boton de eliminar en las filas. Este método es opcional y proviene del delegate de los tableViews.
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//este método lo llama el framework para que yo actualice el modelo de datos. En nuestro, haremos uso del Repository para llevar a cabo la actualización.
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.piscina.mediciones removeObjectAtIndex:indexPath.row];
    [[Repository sharedInstance] actualizarPiscina:self.piscina];
    
    //[self.tableView reloadData]; //después de borrar hay que actualizar la tabla
    
    //usamos el siguiente método para optimizar el proceso de recarga y, de paso, meter una animación al borrado
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ParametrosMedicionViewController* controller = (ParametrosMedicionViewController*)[segue destinationViewController];
    
    NSArray* mediciones = self.piscina.mediciones;
    NSIndexPath* indexPathMedicionSeleccionada = self.tableView.indexPathForSelectedRow;
    Medicion* medicionSeleccionada = [mediciones objectAtIndex:indexPathMedicionSeleccionada.row];
    
    controller.piscina = self.piscina;
    controller.medicion = medicionSeleccionada;
}

- (IBAction)agregarMedicion:(id)sender {
    //creamos una medición con la fecha y hora actual
    NSDate* fecha = [NSDate date]; //por ahora ponemos esto, pero en realidad tendríamos que mostrar un UIAlertController para que el usuario introdujese la fecha.
    Medicion* medicion = [[Medicion alloc] initWithFecha:fecha];
    [self.piscina.mediciones addObject:medicion];
    
    //ejecutamos el método actualizarPiscina para guardar los nuevos contenidos de la piscina donde corresponda (plist, memoria, etc.)
    [[Repository sharedInstance] actualizarPiscina:self.piscina];
    
    [self.tableView reloadData];
}

@end
