package pages;

import java.util.ArrayList;

import org.openqa.selenium.WebDriver;

import helpers.Hproperties;

public class homePage extends basePage {
	private String url = Hproperties.strUrl + Hproperties.strEmp;
	public ArrayList<String> paso = new ArrayList<String>();
	public ArrayList<String> status = new ArrayList<String>();

	public homePage(WebDriver driver) {
		super(driver);
	}

	public void launchHome() {
		try {
			driver.get(url);
			paso.add("Lanzando Front Fenix BAZ");
			status.add("Ok");
		} catch (Exception e) {
			status.add("FAILED");
			System.out.println("Falle al entrar a launchHome");
		}
	}
}
