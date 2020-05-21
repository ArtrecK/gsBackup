package tests;

import java.io.IOException;
import java.util.ArrayList;

import org.testng.annotations.Test;

import pages.homePage;

public class TopenURLTest extends baseTest {

	//@Test
	public static void stepsOpenURL() throws IOException {
		System.out.println("TopenURLTest");
		homePage home = new homePage(driver);
		ArrayList<String> paso = home.paso;
		ArrayList<String> status = home.paso;
		try {
			//home.launchHome();
		} catch (Exception e) {
			System.out.println("Fallo en TopenURLTest");
		}
	}
}
