package codigo;

import java.io.File;
import java.io.IOException;

import java_cup.internal_error;

public class PrincipalLexerCup {

	public static void main(String[] args) throws internal_error, IOException, Exception {
        String ruta2 = "C:/Users/SARA/eclipse-workspace/ProyectoCobol/src/codigo/LexerCup.flex"; // ruta para obtener LexerCup.flex
        
        generar(ruta2);
    }

    public static void generar(String ruta2) throws internal_error, IOException, Exception {
        File archivo;
        // Generar el archivo LexerCup.flex
        archivo = new File(ruta2);
        JFlex.Main.generate(archivo);
        System.out.println("genere del LexerCup.java");
	}

}
