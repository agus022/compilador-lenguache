package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ ,\t,\r,\n]+
%{
    public String lexeme;
%}
%%
/*Tipos de Datos*/
Sg    {return Tipo_STRING;}
INTi  {return Tipo_INT;}
B     {return Tipo_BOOLEAN;}
Db    {return Tipo_DOUBLE;}
Cr    {return Tipo_CHAR;}

/*Modificadores*/
Pb    {return Modificador_PUBLIC;}
Pr    {return Modificador_PRIVATE;}
Pt    {return Modificador_PROTECTED;}

/*Palabras Reservado*/
IF |
ErLiSEr |
FORb |
SWITiCH |
WHILiEr {lexeme=yytext(); return Reservadas;}

{espacio} {/*Ignore*/}
\|\*([^*]|\*[^|])*\*\| { /* Ignore */ }

/* Operadores relacionales */
"=="|"<"|"<="|">"|">="|"!="  { return Operador_Relacional; }

/* Operadores aritméticos */
"+"|"-"|"*"|"/"|"%"      { return Operador_Aritmetico; }

"=" {return Asignacion;}

/* Clases */
Cl                    { return Clase; }

/* Bloques en formato <<...>> */
"<<"([^>]|[\r\n])*">>"  { return Bloque; }

/* Terminador */
";"                     { return Terminador; }

"id" {lexeme=yytext(); return Variable;}
{L}({L}|{D})* {lexeme=yytext(); return Identificador;}

: {lexeme=yytext(); return Condicion;}
("(-"{D}+")")|{D}+ {lexeme=yytext(); return Numero;}
 . {return ERROR;}
