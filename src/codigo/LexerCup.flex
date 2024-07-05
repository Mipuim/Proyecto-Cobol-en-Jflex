package codigo;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char
L=[a-zA-Z_]+
D=[0-9]+
E=[9]
X=[X]
A=[A]
espacio=[ ,\t,\r,\n]+
%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

/* Espacios en blanco */
{espacio} {/*Ignore*/} 

/* Comentarios */
^.{6}\*.*          				{ /* Línea con asterisco en la columna 7 */ }

/* Divisiones de un programa Cobol */
( "IDENTIFICATION DIVISION" ) 	{return new Symbol(sym.IdentificationDivision, yychar, yyline, yytext());}
( "DATA DIVISION" ) 			{return new Symbol(sym.DataDivision, yychar, yyline, yytext());}
( "PROCEDURE DIVISION" ) 		{return new Symbol(sym.ProcedureDivision, yychar, yyline, yytext());}

/* Dar nombre al programa*/
( "PROGRAM-ID" ) 				{return new Symbol(sym.ProgramId, yychar, yyline, yytext());}

/* Declaracion de variables WORKING-STORAGE SECTION*/
("WORKING-STORAGE SECTION")		{return new Symbol(sym.WorkingStorageSection, yychar, yyline, yytext());}

/* Nivel para declarar variables */
( 77|01)					{return new Symbol(sym.Nivel, yychar, yyline, yytext());}

/* Tipos de datos */
( "(" )							{return new Symbol(sym.ParentesisA, yychar, yyline, yytext());}
( ")" )							{return new Symbol(sym.Parentesisc, yychar, yyline, yytext());}
{E}								{return new Symbol(sym.TipoEntero, yychar, yyline, yytext());}
{X}								{return new Symbol(sym.TipoAlfanumerico, yychar, yyline, yytext());}
{A}								{return new Symbol(sym.TipoAlfabeto, yychar, yyline, yytext());}
('S9')							{return new Symbol(sym.TipoSignoNumero, yychar, yyline, yytext());}

/* Valor Especial */
( 'TRUE' | 'FALSE' | 'ZERO' ) 	{return new Symbol(sym.ValorEspecial, yychar, yyline, yytext());}

/* STOP RUN Finalizar el programa */
( "STOP RUN" ) 					{return new Symbol(sym.StopRun, yychar, yyline, yytext());}

/* Acciones */
( "DISPLAY" ) 					{return new Symbol(sym.Display, yychar, yyline, yytext());}
( "ACCEPT" ) 					{return new Symbol(sym.Accept, yychar, yyline, yytext());}
( "COMPUTE" ) 					{return new Symbol(sym.Compute, yychar, yyline, yytext());}

/* Operadores */
( "+" ) 					{return new Symbol(sym.Suma, yychar, yyline, yytext());}
( "-" ) 					{return new Symbol(sym.Resta, yychar, yyline, yytext());}
( "*" ) 					{return new Symbol(sym.Multiplicacion, yychar, yyline, yytext());}
( "/" ) 					{return new Symbol(sym.Division, yychar, yyline, yytext());}

/* Estructuras condicionales y palabras reservadas*/
( "IF" ) 					{return new Symbol(sym.If, yychar, yyline, yytext());}
( "ELSE" )					{return new Symbol(sym.Else, yychar, yyline, yytext());}
( "PIC" )					{return new Symbol(sym.Pic, yychar, yyline, yytext());}
( "VALUE" )					{return new Symbol(sym.Value, yychar, yyline, yytext());}

/* Simbolos condicion */
( "=" ) 					{return new Symbol(sym.Igual, yychar, yyline, yytext());}
( "<" ) 					{return new Symbol(sym.MenorQue, yychar, yyline, yytext());}
( ">" ) 					{return new Symbol(sym.MayorQue, yychar, yyline, yytext());}
( "<=" ) 					{return new Symbol(sym.MenorIgual, yychar, yyline, yytext());}
( ">=" ) 					{return new Symbol(sym.MayorIgual, yychar, yyline, yytext());}
( "<>" ) 					{return new Symbol(sym.Diferente, yychar, yyline, yytext());}

/* Punto para finalizar declaraciones como un ; */
( "." ) 					{return new Symbol(sym.Punto, yychar, yyline, yytext());}

/* Identificador */
{L}({L}|{D})* 				{return new Symbol(sym.Identificador, yychar, yyline, yytext());}

/* Numero */
{D}+ 			{System.out.println("Numero: " + yytext()); return new Symbol(sym.Numero, yychar, yyline, yytext());}


/* Numero decimal */
({D}+"."{D}*)|("."{D}+) 	{return new Symbol(sym.NumeroDecimal, yychar, yyline, yytext());}

/* Cadena*/
\"([^\\\"]|\\[nt])*\" 		{return new Symbol(sym.Cadena, yychar, yyline, yytext());}

/* Error de analisis */
 . 							{return new Symbol(sym.ERROR, yychar, yyline, yytext());}
