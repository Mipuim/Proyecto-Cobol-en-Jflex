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
espacio=[ \t\r\n]+
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

/* Comentarios (Asterisco en la columna 7) */
^.{6}\*.* { /*Ignore*/ }

/* Palabras reservadas de COBOL */
(IDENTIFICATION DIVISION) {return symbol(sym.IDENTIFICATION_DIVISION, yytext());}
(PROGRAM-ID) {return symbol(sym.PROGRAM_ID, yytext());}
(DATA DIVISION) {return symbol(sym.DATA_DIVISION, yytext());}
(WORKING-STORAGE SECTION) {return symbol(sym.WORKING_STORAGE_SECTION, yytext());}
(PROCEDURE DIVISION) {return symbol(sym.PROCEDURE_DIVISION, yytext());}
(DISPLAY) {return symbol(sym.DISPLAY, yytext());}
(ACCEPT) {return symbol(sym.ACCEPT, yytext());}
(COMPUTE) {return symbol(sym.COMPUTE, yytext());}
(STOP RUN) {return symbol(sym.STOP_RUN, yytext());}

/* Operadores */
"+" {return symbol(sym.Suma, yytext());}
"-" {return symbol(sym.Resta, yytext());}
"*" {return symbol(sym.Multiplicacion, yytext());}
"/" {return symbol(sym.Division, yytext());}
"=" {return symbol(sym.Igual, yytext());}
"." {return symbol(sym.Punto, yytext());}
"," {return symbol(sym.Coma, yytext());}

/* Identificador y Números */
{L}({L}|{D})* {return symbol(sym.Identificador, yytext());}
{D}+ {return symbol(sym.Numero, yytext());}

/* Error de análisis */
. {return symbol(sym.ERROR, yytext());}
