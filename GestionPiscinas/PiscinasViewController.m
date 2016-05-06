//
//  PiscinasViewController.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 14/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "PiscinasViewController.h"
#import "Repository.h" //hemos cambiado el import de LocalMemoryDataSource.h a Repository.h, puesto que vamos a ocultar a los view controllers los datasources, puesto que queremos que los data sources sea el repository quien los gestione

@interface PiscinasViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pulsarAgregarPiscina:(id)sender {
    NSString* nombrePiscina = @"Pepito"; //esto lo cambiaremos para que lo coja de un UIAlertController
    Piscina* nuevaPiscina = [[Repository sharedInstance] agregarPiscina:nombrePiscina]; //me da un warning, porque no estoy utilizando el objeto nuevaPiscina dentro de este método, pero me ignoro dicho warning.
        //reemplazamos el localmemorydatasource por repository para evitar que los view controllers trabajen directamente sobre los datasources, puesto que ese trabajo requiere una gestión muy amplia
    
    [self.tableView reloadData];
}

@end
