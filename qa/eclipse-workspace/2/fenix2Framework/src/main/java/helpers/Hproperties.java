package helpers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class Hproperties {

	public static String strUrl;
	public static String strEmp;
	public static String strSuc;
	public static String strWS;
	public static String strPsw;
	public static String strPath;
	public static String strCU;

	public static String leerPath() {
		strPath = new File("").getAbsolutePath();
		return strPath;
	}

	public static void leerProperties() {
		try {
			Properties propiedades = new Properties();
			propiedades.load(new FileInputStream(strPath + "/Properties/Config.properties"));

			strUrl = propiedades.getProperty("urlWeb");
			strEmp = propiedades.getProperty("empleado");
			strSuc = propiedades.getProperty("sucursal");
			strWS = propiedades.getProperty("estacion");
			strPsw = propiedades.getProperty("contrasenia");
			strCU = propiedades.getProperty("clienteuni");
		} catch (FileNotFoundException e) {
			System.out.println("Error, el archivo no existe, Hproperties");
		} catch (IOException e) {
			System.out.println("Error, no se puede leer el archivo, Hproperties");
		}
	}
}
