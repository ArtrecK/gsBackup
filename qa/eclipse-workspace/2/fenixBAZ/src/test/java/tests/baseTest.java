package tests;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;

import helpers.Hproperties;

public class baseTest {
	
	public static String strPaso = "";
	String strPath = Hproperties.leerPath();
	public static WebDriver driver;
	String driverPath = strPath + "/Recursos/Driver/chromedriver";
	
	@BeforeClass
	public void setDriver() {
		strPaso = "Invocando al metodo que lee las properties";
		Hproperties.leerProperties();
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--disable-notifications");
		strPaso = "Invocando el webdriver";
		System.setProperty("webdriver.chrome.driver", driverPath);
		this.driver = new ChromeDriver(options);
		this.driver.manage().window().maximize();
	}
	
	@AfterClass
	public void quitDriver() {
		//driver.quit();
	}

}
