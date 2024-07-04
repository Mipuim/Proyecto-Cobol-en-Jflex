package codigo;

import java.awt.Color;
import java.awt.EventQueue;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import java_cup.runtime.Symbol;

import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JTextArea;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.awt.event.ActionEvent;
import java.io.BufferedReader;
import java.io.Reader;
import java.io.StringReader;
import java.nio.file.Files;

import javax.swing.JScrollPane;

public class FrmPrincipal extends JFrame {

	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	protected JTextArea txtAnalizar;
	protected JTextArea txtResultado_Lexico;
	protected JTextArea txtResultado_Sintactico;
	
	private final static String nuevaLinea= "\n";
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					FrmPrincipal frame = new FrmPrincipal();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public FrmPrincipal() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 449, 604);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));

		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(10, 43, 414, 165);
		contentPane.add(scrollPane);
		
		JTextArea txtAnalizar = new JTextArea();
		scrollPane.setViewportView(txtAnalizar);
		
		JScrollPane scrollPane_1 = new JScrollPane();
		scrollPane_1.setBounds(10, 253, 414, 216);
		contentPane.add(scrollPane_1);
		
		JTextArea txtResultado_Lexico = new JTextArea();
		scrollPane_1.setViewportView(txtResultado_Lexico);
		
		JButton btnBuscar = new JButton("Buscar");
		btnBuscar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JFileChooser choser = new JFileChooser();
				choser.showOpenDialog(null);
				File archivo = new File(choser.getSelectedFile().getAbsolutePath());
				
				try {
					String cadena = new String(Files.readAllBytes(archivo.toPath()));
					txtAnalizar.setText(cadena);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		});
		btnBuscar.setBounds(10, 11, 414, 23);
		contentPane.add(btnBuscar);
		
		JButton btnAnalizarLexico = new JButton("Analizar-Lexico");
		btnAnalizarLexico.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {	
				
				try {
					int contador = 1;
					String expresion = txtAnalizar.getText();
					Lexer lexer = new Lexer(new StringReader(expresion));
					String resultado = "Linea" + contador + "\t\tSIMBOLO" + nuevaLinea;
					while (true) {
						Tokens token = lexer.yylex();
						if (token == null) {
							txtResultado_Lexico.setText(resultado);
							return;
						}
						switch (token) {
						case Linea:
							contador++;
							resultado += "Linea " + contador + nuevaLinea;
							System.out.println("hola linea");
							break;
						case IdentificationDivision:
							resultado += "<IDENTIFICATION DIVISION>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case PogramId:
							resultado += "<PROGRAM-ID>\t" + lexer.lexeme + nuevaLinea;
							break;
						case DataDivision:
							resultado += "<DATA DIVISION>\t" + lexer.lexeme + nuevaLinea;
							break;
						case WorkingStorageSection:
							resultado += "<WORKING-STORAGE SECTION>\t" + lexer.lexeme + nuevaLinea;
							break;
						case ProcedureDivision:
							resultado += "<PROCEDURE DIVISION>\t" + lexer.lexeme + nuevaLinea;
							break;
						case Display:
							resultado += "<DISPLAY>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Accept:
							resultado += "<ACCEPT>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Compute:
							resultado += "<COMPUTE>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case StopRun:
							resultado += "<STOP RUN>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Pic:
							resultado += "<PIC>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Value:
							resultado += "<VALUE>\t\t" + lexer.lexeme + nuevaLinea;
							break;
							
							
						case If:
							resultado += "<IF>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case MayorQue:
							resultado += "<MAYOR QUE>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case MenorQue:
							resultado += "<MENOR QUE>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case MayorIgual:
							resultado += "<MAYOR IGUAL>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case MenorIgual:
							resultado += "<MENOR IGUAL>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Diferente:
							resultado += "<DIFERENTE>\t\t" + lexer.lexeme + nuevaLinea;
							break;
							
							
						case Suma:
							resultado += "<Suma>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Resta:
							resultado += "<Resta>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Multiplicacion:
							resultado += "<Multiplicacion>\t" + lexer.lexeme + nuevaLinea;
							break;
						case Division:
							resultado += "<Division>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Igual:
							resultado += "<Igual>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Punto:
							resultado += "<Punto>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Coma:
							resultado += "<Coma>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Identificador:
							resultado += "<Identificador>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case Numero:
							System.out.println("hola numero");
							resultado += "<Numero>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						case ERROR:
							resultado += "<simbolo NDF>\t\t" + lexer.lexeme + nuevaLinea;
							break;
						default:
							System.out.println("holamundo");
							resultado += "<" + lexer.lexeme + ">" + nuevaLinea;
							break;
						}
					}
				} catch (IOException e1) {
					e1.printStackTrace();
				}

			}
		});
		btnAnalizarLexico.setBounds(10, 219, 414, 23);
		contentPane.add(btnAnalizarLexico);
		
		JTextArea txtResultado_Sintactico = new JTextArea();
		txtResultado_Sintactico.setBounds(12, 512, 412, 35);
		contentPane.add(txtResultado_Sintactico);
		
		JButton btnAnalizarSintactico = new JButton("Analizar - Sintactico");
		btnAnalizarSintactico.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {

				String ST = txtAnalizar.getText();
				Sintax s = new Sintax(new codigo.LexerCup(new StringReader(ST)));

				try {
					s.parse();
					txtResultado_Sintactico.setText("Analisis realizado correctamente");
					txtResultado_Sintactico.setForeground(new Color(25, 111, 61));
				} catch (Exception ex) {
					Symbol sym = s.getS();
					txtResultado_Sintactico.setText("Error de sintaxis. Linea: " + (sym.right + 1) + " Columna: "
							+ (sym.left + 1) + ", Texto: \"" + sym.value + "\"");
					txtResultado_Sintactico.setForeground(Color.red);
				}

			}
		});
		btnAnalizarSintactico.setBounds(10, 479, 414, 23);
		contentPane.add(btnAnalizarSintactico);
		 	
	}
}