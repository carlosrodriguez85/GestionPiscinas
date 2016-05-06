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

@interface MedicionesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MedicionesViewController

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
    return self.piscina.mediciones.count; //hay tantas filas como mediciones en la piscina
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CeldaMedicion" forIndexPath:indexPath];
    Medicion* medicion = [self.piscina.mediciones objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [medicion.fecha description]; //por ahora utilizamos el método description, pero luego será un NSDateFormatter. Esto es simplemente para no complicar el código más.
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
