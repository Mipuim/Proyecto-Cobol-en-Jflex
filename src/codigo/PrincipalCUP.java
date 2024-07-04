package codigo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java_cup.internal_error;
import java_cup.Main;


public class PrincipalCUP {

    public static void main(String[] args) throws internal_error, IOException, Exception {
        String ruta2 = "C:/Users/SARA/eclipse-workspace/ProyectoCobol/src/codigo/LexerCup.flex"; // ruta para obtener LexerCup.flex
        String[] rutaS = {"-parser", "Sintax", "-symbols", "sym", "C:/Users/SARA/eclipse-workspace/ProyectoCobol/src/codigo/Sintaxis.cup"}; // ruta para Sintaxis.cup
        generar(ruta2, rutaS);
    }

    public static void generar(String ruta2, String[] rutaS) throws internal_error, IOException, Exception {
        File archivo;
        // Generar el archivo LexerCup.flex
        archivo = new File(ruta2);
        JFlex.Main.generate(archivo);
        System.out.println("genere del LexerCup.java");

  /*      // Crear una instancia de ComplexSymbolFactory y asignarla al parser
        ComplexSymbolFactory csf = new ComplexSymbolFactory();
        lr_parser parser = new java_cup.runtime.lr_parser(csf); //en esta linea me sale error
        */
        // Ejecutar CUP para generar los archivos de análisis sintáctico
        java_cup.Main.main(rutaS);

        // Mover sym.java generado a su destino final
        Path rutaSym = Paths.get("C:/Users/SARA/eclipse-workspace/ProyectoCobol/src/codigo/sym.java");
        if (Files.exists(rutaSym)) {
            Files.delete(rutaSym);
            
        }
        Files.move(
                Paths.get("C://Users//SARA//eclipse-workspace//ProyectoCobol//sym.java"),
                Paths.get("C:/Users/SARA/eclipse-workspace/ProyectoCobol/src/codigo/sym.java")
        );

        // Mover Sintaxis.java generado a su destino final
        Path rutaSin = Paths.get("C:/Users/SARA/eclipse-workspace/ProyectoCobol/src/codigo/Sintax.java");
        if (Files.exists(rutaSin)) {
            Files.delete(rutaSin);
            
        }
        Files.move(
                Paths.get("C://Users//SARA//eclipse-workspace//ProyectoCobol//Sintax.java"),
                Paths.get("C:/Users/SARA/eclipse-workspace/ProyectoCobol/src/codigo/Sintax.java")
        );
    }
}
