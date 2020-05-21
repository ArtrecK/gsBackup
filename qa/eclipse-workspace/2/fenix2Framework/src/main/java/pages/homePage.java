package pages;

import java.util.ArrayList;

import org.openqa.selenium.WebDriver;

import helpers.Hproperties;

public class homePage extends basePage {
	private String url = Hproperties.strUrl + Hproperties.strEmp + "/" + Hproperties.strSuc + "/" + Hproperties.strWS
			+ "/" + Hproperties.strPsw;
	public ArrayList<String> paso = new ArrayList<String>();
	public ArrayList<String> status = new ArrayList<String>();

	public homePage(WebDriver driver) {
		super(driver);
		System.out.println();
	}

	public void launchHome() {
		try {
			System.out.println();
			driver.get(url);
			paso.add("Lanzando Front Fenix 2.0");
			status.add("Ok");
		} catch (Exception e) {
			status.add("FAILED");
			System.out.println("Falle al entrar a launchHome");
		}
	}

}
