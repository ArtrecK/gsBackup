package helpers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class Hproperties {

	public static String strUrl;
	public static String strEmp;
	public static String strPath;

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
		} catch (FileNotFoundException e) {
			System.out.println("Error, el archivo no existe, Hproperties");
		} catch (IOException e) {
			System.out.println("Error, no se puede leer el archivo, Hproperties");
		}
	}
}
