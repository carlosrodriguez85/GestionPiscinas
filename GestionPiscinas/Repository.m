//
//  Repository.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 17/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "Repository.h"
#import "LocalMemoryDataSource.h"
#import "PlistDataSource.h" //añadimos el datasource, para que entienda el repositorio que hay PlistDataSources
#import "iCloudDataSource.h"
#import "ExcelDataSource.h"

@implementation Repository

//en swift: class var repository = Repository()

static Repository* repository = nil;

+(Repository*) sharedInstance
{
    //ESTO NO DEBERÍA HACERSE, PUESTO QUE SI NO SE CREARÍAN DIFERENTES OBJETOS CADA VEZ QUE SE LLAMASE A ESTE MÉTODO:
    // Repository* resultado = [[Repository alloc] init];
    // return resultado;
    
    if (repository == nil) {
        /*
         En dos líneas (versión 1):
         Repository* repo = [Repository alloc];
         repo = [repo init];
         */
        
        /*
         En dos líneas (versión 2):
         Repository* auxiliar = [Repository alloc];
         Repository* repo = [auxiliar init];
         */
        
        repository = [[Repository alloc] init];
    }
    
    return repository;
}

-(Piscina*)agregarPiscina:(NSString*)nombre
{
    Piscina* nuevaPiscina = [[LocalMemoryDataSource sharedInstance] agregarPiscina:nombre];
    
    //en una linea:
    [[PlistDataSource sharedInstance] agregarPiscina:nombre];
    
    /*
     En dos líneas:
     PlistDataSource* dataSource = [PlistDataSource sharedInstance];
     [dataSource agregarPiscina:nombre];*/
    
    [[iCloudDataSource sharedInstance] agregarPiscina:nombre];
    
    return nuevaPiscina;
}

-(void)actualizarPiscina:(Piscina*)piscina
{
    [[LocalMemoryDataSource sharedInstance] actualizarPiscina:piscina];
    [[PlistDataSource sharedInstance] actualizarPiscina:piscina];
    [[iCloudDataSource sharedInstance] actualizarPiscina:piscina];
}

-(void)eliminarPiscina:(Piscina*)piscina
{
    [[LocalMemoryDataSource sharedInstance] eliminarPiscina:piscina];
    [[PlistDataSource sharedInstance] eliminarPiscina:piscina];
    [[iCloudDataSource sharedInstance] eliminarPiscina:piscina];
}

-(NSArray*)obtenerPiscinas
{
    NSArray* piscinas = [[LocalMemoryDataSource sharedInstance] obtenerPiscinas];// lee de memoria primero, y si no hay nada en memoria, entonces lo lee del fichero.
    if (piscinas.count == 0){ //no hay nada en memoria
        piscinas = [[PlistDataSource sharedInstance] obtenerPiscinas]; //tomar del plist
        NSArray* piscinasEnlaNube = [[iCloudDataSource sharedInstance] obtenerPiscinas]; //cogemos las piscinas de la nube
        
        if (piscinas.count == 0){ //es decir, si en el plist no hay piscinas
            //si se da esta circunstancia, entonces hay que guardar en el plist local todas las piscinas que hubiese en la nube.
            [[PlistDataSource sharedInstance] sustituirPiscinas:piscinasEnlaNube];
            piscinas = piscinasEnlaNube;
        }
        else if (piscinas.count > 0 && piscinasEnlaNube.count == 0){ //hemos guardado en local, pero no hay nada en la nube
            //metemos en la nube todo lo que haya en el plist
            [[iCloudDataSource sharedInstance] sustituirPiscinas:piscinas];
        }
        else if (piscinas.count != piscinasEnlaNube.count) { //si hay diferencia entre las piscinas que hay en local y las que hay en la nube, prevalece lo de la nube siempre
            [[PlistDataSource sharedInstance] sustituirPiscinas:piscinasEnlaNube];
            piscinas = piscinasEnlaNube;
        }
        
        [[LocalMemoryDataSource sharedInstance] sustituirPiscinas:piscinas]; //esto sincroniza lo que hay en disco con lo que hay en memoria (que siempre que se inicia la aplicación está siempre vacío)
    }
    
    return piscinas;
}

-(void)exportar {
    NSArray* piscinas = [[Repository sharedInstance] obtenerPiscinas];
    NSString* nombreFichero = [NSString stringWithFormat:@"exportacion.xlsx"];
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* pathCompleto = [path stringByAppendingPathComponent:nombreFichero];
    
    [[ExcelDataSource sharedInstance] exportar:piscinas aFichero:pathCompleto];
}

@end
