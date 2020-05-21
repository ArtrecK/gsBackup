package tests;

import java.awt.List;
import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.Wait;
import org.testng.annotations.Test;

import pages.homePage;
import pages.misResultadosPage;

public class TmisResultados extends baseTest {

	@Test
	public static void stepsMisResultados() throws IOException {
		misResultadosPage resultp = new misResultadosPage(driver);
		homePage home = new homePage(driver);
		int timeOutHome = 10000;
		int timeOutSemi = 5000;
		ArrayList<String> paso = resultp.paso;
		ArrayList<String> status = resultp.status;

		home.launchHome();
		try {
			//Thread.sleep(timeOutHome);
			//resultp.clickSemana();
			//Thread.sleep(timeOutSemi);
			//resultp.clickDia();
			Thread.sleep(timeOutSemi);
			//resultp.clickLineasObj();
			//Thread.sleep(timeOutSemi);
			//resultp.clickMisClientes();
			//Thread.sleep(timeOutSemi);
			resultp.clickBanner();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
