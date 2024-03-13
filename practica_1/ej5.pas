program ej5;
{preguntar por espacios y si estan bien hechas las leidas}
type
    celular = record
        codigo:integer;
        nombre: string[12];
        descripcion:string[20];
        marca: string[12];
        precio:double;
        stock_minimo:integer;
        stock_disponible:integer;
    end;

type archivo = file of celular;
{metodos correspondientes al ej6}
procedure agregar_celular(var arch:archivo);
var c:celular;
codigo_entry:integer;
nombre_entry: string[12];
descri