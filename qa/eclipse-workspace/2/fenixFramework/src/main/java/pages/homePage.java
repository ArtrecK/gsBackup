package pages;

import java.util.ArrayList;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import helpers.*;

public class homePage extends basePage {
		
	private String url = Hproperties.strUrl+Hproperties.strEmp+"/"+Hproperties.strSuc+"/"+Hproperties.strWS+"/"+Hproperties.strPsw;
	public ArrayList<String> paso = new ArrayList<String>();
	public ArrayList<String> status = new ArrayList<String>();
	
	public homePage(WebDriver driver) {
		super(driver);
		System.out.println("Entre a homePage");
	}
	
	public void launchHome() {
		try {
			System.out.println(url);
			driver.get(url);
			paso.add("Lanzando Front Fenix");
			status.add("OK");
		}
		catch(Exception e) {
			status.add("FAILED");
			System.out.println("Falle al entrar a launchHome");
		}
	}
}
