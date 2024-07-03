package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ \t\r]+
nueva_linea=[\n]
%{
    public String lexeme;
%}
%%

{espacio}          {}
^.{6}\*.*          { /* Línea con asterisco en la columna 7 */ }
{nueva_linea}      {return Linea;}
^.{7}.*("IDENTIFICATION DIVISION") 	{lexeme=yytext().substring(yytext().indexOf("IDENTIFICATION DIVISION")); return IDENTIFICATION_DIVISION;}
^.{7}.*(PROGRAM-ID)       			{lexeme=yytext().substring(yytext().indexOf("PROGRAM-ID")); return PROGRAM_ID;}
^.{7}.*("DATA DIVISION")    		{lexeme=yytext().substring(yytext().indexOf("DATA DIVISION")); return DATA_DIVISION;}
^.{7}.*("WORKING-STORAGE SECTION") 	{lexeme=yytext().substring(yytext().indexOf("WORKING-STORAGE SECTION")); return WORKING_STORAGE_SECTION;}
^.{7}.*("PROCEDURE DIVISION") 		{lexeme=yytext().substring(yytext().indexOf("PROCEDURE DIVISION")); return PROCEDURE_DIVISION;}
^.{7}.*(DISPLAY)          			{lexeme=yytext().substring(yytext().indexOf("DISPLAY")); return DISPLAY;}
^.{7}.*(ACCEPT)           			{lexeme=yytext().substring(yytext().indexOf("ACCEPT")); return ACCEPT;}
^.{7}.*(COMPUTE)          			{lexeme=yytext().substring(yytext().indexOf("COMPUTE")); return COMPUTE;}
^.{7}.*("STOP RUN")         		{lexeme=yytext().substring(yytext().indexOf("STOP RUN")); return STOP_RUN;}
^.{7}.*\+                		{lexeme=yytext().substring(yytext().indexOf("+")); return Suma;}
^.{7}.*-                		{lexeme=yytext().substring(yytext().indexOf("-")); return Resta;}
^.{7}.*\*                		{lexeme=yytext().substring(yytext().indexOf("*")); return Multiplicacion;}
^.{7}.*\/                		{lexeme=yytext().substring(yytext().indexOf("/")); return Division;}
^.{7}.*=                		{lexeme=yytext().substring(yytext().indexOf("=")); return Igual;}
^.{7}.*\.                		{lexeme=yytext().substring(yytext().indexOf(".")); return Punto;}
^.{7}.*,                		{lexeme=yytext().substring(yytext().indexOf(",")); return Coma;}
^.{7}.*{L}({L}|{D})*      {lexeme=yytext().substring(7); return Identificador;}
^.{7}.*{D}+               {lexeme=yytext().substring(7); return Numero;}
^.{7}.*.                  {return ERROR;}

.*{0,6}                  { /* Ignorar cualquier cosa antes de la columna 8 */ }