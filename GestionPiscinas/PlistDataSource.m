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
    
    return dataSource;
}

-(Piscina *)agregarPiscina:(NSString *)nombre
{
    Piscina* piscina = [[Piscina alloc] initWithNombre:nombre];
    
    
    
    return piscina;
}

-(void)actualizarPiscina:(Piscina*)piscina
{
    
}

-(void)eliminarPiscina:(Piscina*)piscina
{
    
}

-(NSArray*)obtenerPiscinas
{
    
}

@end
