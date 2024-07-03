package codigo;

import java.io.File;

public class PrincipalLexer {

	public static void main(String[] args) {
		String ruta = "C:/Users/SARA/eclipse-workspace/ProyectoCobol/src/codigo/Lexer.flex";
        generarLexer(ruta);
	}
	
	public static void generarLexer(String ruta){
        File archivo = new File(ruta);
        JFlex.Main.generate(archivo);
    }

	

}
