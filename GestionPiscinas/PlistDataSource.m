//
//  PlistDataSource.m
//  GestionPiscinas
//
//  Created by Carlos Rodríguez Domínguez on 28/3/16.
//  Copyright © 2016 Carlos Rodríguez Domínguez. All rights reserved.
//

#import "PlistDataSource.h"

@interface PlistDataSource()
@property (nonatomic, strong) NSString* pathPlist;
@end

@implementation PlistDataSource

static PlistDataSource* dataSource = nil;

-(instancetype)init
{
    self = [super init];
    if (self){
        //obtener el path para el fichero plist que va a guardar las piscinas. Ese fichero se va a llamar "piscinas.plist" y vamos a guardarlo en la carpeta "Documents".
 //       NSSearchPathForDirectoriesInDomains(<#NSSearchPathDirectory directory#>, <#NSSearchPathDomainMask domainMask#>, <#BOOL expandTilde#>)
        NSString* documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]; //hay que poner el [0] al final, porque este método devuelve un array con múltiples path para el path solicitado. Nosotros solo queremos el 0, porque desde hace bastantes años, en iOS es el único que importa. El índice 0, en este caso, corresponde al path del directory "Documents".
        NSLog(@"Path carpeta Documents: %@", documentsPath);
        NSString* pathPiscinasPlist = [documentsPath stringByAppendingPathComponent:@"piscinas.plist"]; //este método agrega al path el nombre del fichero que pasemos como parámetro, agregando las / u otros caracteres que sean necesarios.
        self.pathPlist = pathPiscinasPlist;
        NSLog(@"Path fichero piscinas.plist: %@", pathPiscinasPlist);
    }
    
    return self;
}

+(instancetype)sharedInstance
{
    if (dataSource == nil){
        dataSource = [[PlistDataSource alloc] init];
    }
    
    dataSource.cuantasReferencias++;
    
    NSLog(@"Se ha referenciado al singleton de la clase PlistDataSource %d veces", dataSource.cuantasReferencias);
    
    return dataSource;
}

-(Piscina *)agregarPiscina:(NSString *)nombre
{
    Piscina* piscina = [[Piscina alloc] initWithNombre:nombre];
    
    //para agregar una piscina, vamos a obtener el listado completo de piscinas, agregarla la nueva, y guardar el listado completo de nuevo dentro del fichero
    NSArray* piscinasLeidas = [self obtenerPiscinas];
    NSMutableArray* piscinas = [[NSMutableArray alloc] initWithArray:piscinasLeidas];
    [piscinas addObject:piscina];// agregamos la piscina al listado completo de piscinas en memoria
    
    //guardamos el listado actualizado de piscinas en un fichero
    [NSKeyedArchiver archiveRootObject:piscinas toFile:self.pathPlist];
    
    return piscina;
}

-(void)actualizarPiscina:(Piscina*)piscina
{
    //para actualizar una piscina, vamos a obtener el listado completo de piscinas, buscar el índice en el que estaba la antigua y volver a guardar el listado completo de nuevo dentro del fichero
    NSArray* piscinasLeidas = [self obtenerPiscinas];
    NSMutableArray* piscinas = [[NSMutableArray alloc] initWithArray:piscinasLeidas];
    
    NSInteger indice = 0;
    for (Piscina* p in piscinas){ //recorremos el listado de piscinas
        if ([p.nombre isEqualToString:piscina.nombre]){ //si la piscina actual tiene el mismo nombre que la piscina que queremos actualizar, terminamos el bucle. indice contiene el índice en el que está la piscina que queremos actualizar
            break;
        }
        indice++;
    }
    
    if (indice < piscinas.count){ //hemos encontrado una piscina, puesto que si indice >= piscinas.count, entonces es que la piscina a actualizar no estaba en el array
        [piscinas replaceObjectAtIndex:indice withObject:piscina];
        
        //guardamos el listado actualizado de piscinas en un fichero
        [NSKeyedArchiver archiveRootObject:piscinas toFile:self.pathPlist];
    }
}

-(void)sustituirPiscinas:(NSArray *)piscinas
{
    [NSKeyedArchiver archiveRootObject:piscinas toFile:self.pathPlist];
}

-(void)eliminarPiscina:(Piscina*)piscina
{
    //para eliminar una piscina, vamos a obtener el listado completo de piscinas, buscar el índice en el que esta la piscina, eliminar la piscina del array y volver a guardar el listado completo de nuevo dentro del fichero
    NSArray* piscinasLeidas = [self obtenerPiscinas];
    NSMutableArray* piscinas = [[NSMutableArray alloc] initWithArray:piscinasLeidas];
    
    NSInteger indice = 0;
    for (Piscina* p in piscinas){ //recorremos el listado de piscinas
        if ([p.nombre isEqualToString:piscina.nombre]){ //si la piscina actual tiene el mismo nombre que la piscina que queremos eliminar, terminamos el bucle. indice contiene el índice en el que está la piscina que queremos eliminar
            break;
        }
        indice++;
    }
    
    if (indice < piscinas.count){ //hemos encontrado una piscina, puesto que si indice >= piscinas.count, entonces es que la piscina a eliminar no estaba en el array
        [piscinas removeObjectAtIndex:indice];
        
        //guardamos el listado actualizado de piscinas en un fichero
        [NSKeyedArchiver archiveRootObject:piscinas toFile:self.pathPlist];
    }
}

-(NSArray*)obtenerPiscinas
{
    // obtiene el NSArray de piscinas desde el plist. NSKeyedUnarchiver es la API que permite leer desde un plist cualquier objeto guardado, teniendo que darle como parámetro el path del plist a leer.
    NSArray* resultado = [NSKeyedUnarchiver unarchiveObjectWithFile:self.pathPlist];
    if (resultado == nil){ //si el plist no existe, cuando nos pidan las piscinas, decimos que no hay (devolvemos un array vacio)
        return [[NSArray alloc] init];
    }
    else{
        return resultado; //devuelve las piscinas que estaban guardadas en el plist
    }
}

@end
