//
//  PiscinasViewController.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "PiscinasViewController.h"
#import "Repository.h" //hemos cambiado el import de LocalMemoryDataSource.h a Repository.h, puesto que vamos a ocultar a los view controllers los datasources, puesto que queremos que los data sources sea el repository quien los gestione
#import "MedicionesViewController.h"

@interface PiscinasViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString* nombreDelFicheroExportado;

@end

@implementation PiscinasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSArray* piscinas = [[Repository sharedInstance] obtenerPiscinas]; //reemplazamos el localmemorydatasource por repository para evitar que los view controllers trabajen directamente sobre los datasources, puesto que ese trabajo requiere una gestión muy amplia
    return piscinas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CeldaPiscina" forIndexPath:indexPath];
    
    NSArray* piscinas = [[Repository sharedInstance] obtenerPiscinas]; //reemplazamos el localmemorydatasource por repository para evitar que los view controllers trabajen directamente sobre los datasources, puesto que ese trabajo requiere una gestión muy amplia
    Piscina* piscina = [piscinas objectAtIndex:indexPath.row];
    
    cell.textLabel.text = piscina.nombre;
    
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
    NSArray* piscinas = [[Repository sharedInstance] obtenerPiscinas];
    Piscina* piscinaAEliminar = [piscinas objectAtIndex:indexPath.row];
    [[Repository sharedInstance] eliminarPiscina:piscinaAEliminar];
    
    //[self.tableView reloadData]; //después de borrar hay que actualizar la tabla
    
    //usamos el siguiente método para optimizar el proceso de recarga y, de paso, meter una animación al borrado
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //obtengo una referencia al controller que se va a mostrar a continuación
    MedicionesViewController* controller = (MedicionesViewController*)[segue destinationViewController];
    
    //obtengo todas las piscinas
    NSArray* piscinasRecuperadas = [[Repository sharedInstance] obtenerPiscinas];
    
    //obtengo el indexpath de la fila que he tocado en el tableview
    NSIndexPath* indexPathFilaSeleccionada = [self.tableView indexPathForSelectedRow];
    
    //de las piscinas obtenidas, recupero la piscina que está en el mismo indexpath que la fila seleccionada
    Piscina* piscinaSeleccionada = [piscinasRecuperadas objectAtIndex:indexPathFilaSeleccionada.row];
    
    //meto la piscina seleccionada en el controller
    controller.piscina = piscinaSeleccionada;
}

#pragma mark - IBActions

- (IBAction)pulsarAgregarPiscina:(id)sender {
    //pedimos el nombre de la piscina con un uialertcontroller
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Nombre" message:@"Por favor, introduzca el nombre de la nueva piscina" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Nombre de piscina";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Agregar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField* textField = alertController.textFields[0];
        NSString* nombrePiscina = textField.text;
        Piscina* nuevaPiscina = [[Repository sharedInstance] agregarPiscina:nombrePiscina]; //me da un warning, porque no estoy utilizando el objeto nuevaPiscina dentro de este método, pero me ignoro dicho warning.
        //reemplazamos el localmemorydatasource por repository para evitar que los view controllers trabajen directamente sobre los datasources, puesto que ese trabajo requiere una gestión muy amplia
        
        [self.tableView reloadData];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil]; //esta es la línea que muestra realmente el alertcontroller. sin esto, el alertcontroller no se muestra en pantalla
}

- (IBAction)exportarPulsado:(id)sender {
    //hemos cambiado en el método exportar -(void) por -(NSString*). Aquí recuperamos ese valor NSString
    self.nombreDelFicheroExportado = [[Repository sharedInstance] exportar];
    
    QLPreviewController* previewController = [[QLPreviewController alloc] init];
    previewController.dataSource = self; //esto lo ponemos porque QLPreviewController requiere tener un datasource
    
    //este método hay que ponerlo para que se muestre un viewcontroller desde el viewcontroller en el que estamos actualmente
    [self presentViewController:previewController animated:YES completion:NULL];
}

#pragma mark - QLPreviewController datasource

-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    //según la documentación, podemos devolver o un NSURL o un objeto de una clase cualquier que adopte el protocolo QLPreviewItem. Hemos optado por NSURL por comodidad.
    return [NSURL fileURLWithPath:self.nombreDelFicheroExportado];
}

@end
