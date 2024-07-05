package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
E=[9]
X=[X]
A=[A]
S=[S9]
espacio=[ \t\r]+
nueva_linea=[\n]
%{
    public String lexeme;
%}
%%

{espacio}          {}
^.{6}\*.*          { /* Línea con asterisco en la columna 7 */ }
{nueva_linea}      {return Linea;}
^.{7}.*("IDENTIFICATION DIVISION") 	{lexeme=yytext().substring(yytext().indexOf("IDENTIFICATION DIVISION")); 	return IdentificationDivision;}
^.{7}.*(PROGRAM-ID)       			{lexeme=yytext().substring(yytext().indexOf("PROGRAM-ID")); 				return PogramId;}
^.{7}.*("DATA DIVISION")    		{lexeme=yytext().substring(yytext().indexOf("DATA DIVISION")); 				return DataDivision;}
^.{7}.*("WORKING-STORAGE SECTION") 	{lexeme=yytext().substring(yytext().indexOf("WORKING-STORAGE SECTION")); 	return WorkingStorageSection;}
^.{7}.*("PROCEDURE DIVISION") 		{lexeme=yytext().substring(yytext().indexOf("PROCEDURE DIVISION")); 		return ProcedureDivision;}
^.{7}.*(DISPLAY)          			{lexeme=yytext().substring(yytext().indexOf("DISPLAY")); 					return Display;}
^.{7}.*(ACCEPT)           			{lexeme=yytext().substring(yytext().indexOf("ACCEPT")); 					return Accept;}
^.{7}.*(COMPUTE)          			{lexeme=yytext().substring(yytext().indexOf("COMPUTE")); 					return Compute;}
^.{7}.*("STOP RUN")         		{lexeme=yytext().substring(yytext().indexOf("STOP RUN")); 					return StopRun;}
^.{7}.*(PIC)         				{lexeme=yytext().substring(yytext().indexOf("PIC")); 						return Pic;}
^.{7}.*(VALUE)         			{lexeme=yytext().substring(yytext().indexOf("VALUE")); 							return Value;}

^.{7}.*(<>)                		{lexeme=yytext(); 		return Diferente;}
^.{7}.*>                		{lexeme=yytext().substring(yytext().indexOf(">")); 			return MayorQue;}
^.{7}.*<                		{lexeme=yytext().substring(yytext().indexOf("<")); 			return MenorQue;}
^.{7}.*>=                		{lexeme=yytext().substring(yytext().indexOf(">=")); 		return MayorIgual;}
^.{7}.*<=                		{lexeme=yytext().substring(yytext().indexOf("<=")); 		return MenorIgual;}
^.{7}.*(IF)                		{lexeme=yytext().substring(yytext().indexOf("IF")); 		return If;}
^.{7}.*(ELSE)                	{lexeme=yytext().substring(yytext().indexOf("ELSE")); 		return Else;}
^.{7}.*\(                		{lexeme=yytext().substring(yytext().indexOf("(")); 			return ParentesisA;}
^.{7}.*\)                		{lexeme=yytext().substring(yytext().indexOf(")")); 			return ParentesisC;}

^.{7}.*{E}                		{lexeme=yytext().substring(7); 							return TipoEntero;}
^.{7}.*{X}                		{lexeme=yytext().substring(7); 							return TipoAlfanumerico;}
^.{7}.*{A}                		{lexeme=yytext().substring(7); 							return TipoAlfabeto;}
^.{7}.*("S9")                		{lexeme=yytext().substring(7); 							return TipoSignoNumero;}

^.{7}.*\+                		{lexeme=yytext().substring(yytext().indexOf("+")); 		return Suma;}
^.{7}.*-                		{lexeme=yytext().substring(yytext().indexOf("-")); 		return Resta;}
^.{7}.*\*                		{lexeme=yytext().substring(yytext().indexOf("*")); 		return Multiplicacion;}
^.{7}.*\/                		{lexeme=yytext().substring(yytext().indexOf("/")); 		return Division;}
^.{7}.*=                		{lexeme=yytext().substring(yytext().indexOf("=")); 		return Igual;}
^.{7}.*\.                		{lexeme=yytext().substring(yytext().indexOf(".")); 		return Punto;}

^.{7}.*{L}({L}|{D})*      {lexeme=yytext().substring(7); return Identificador;}
^.{7}.*{D}+               {lexeme=yytext().substring(7); 	return Numero;}
^.{7}.*.                  {return ERROR;}

.*{0,6}                  { /* Ignorar cualquier cosa antes de la columna 8 */ }