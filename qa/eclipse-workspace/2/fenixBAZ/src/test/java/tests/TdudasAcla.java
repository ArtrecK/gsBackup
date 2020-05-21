package tests;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Set;

import org.openqa.selenium.By;
import org.testng.annotations.Test;

import pages.homePage;
import pages.navegacionPages;

public class TdudasAcla extends baseTest {

	//@Test
	public static void aclaracionTest() throws IOException {
		homePage home = new homePage(driver);
		navegacionPages nPage = new navegacionPages(driver);

		home.launchHome();
		nPage.closePopUpPrincipal();
		nPage.pausa(5000);
		nPage.click("//a");
		nPage.pausa(2500);
		nPage.listaItem("//select", "CONSUMO");
		System.out.println("Lista tipo producto");
		nPage.pausa(2500);
		nPage.listaItem("//div[2]/select", "NO PUEDO REALIZAR GESTIONES");
		System.out.println("Lista tipo tema");
		nPage.pausa(2500);
		nPage.asignaValor("//input", "7751615294");
		System.out.println("Asigna numero");
		nPage.pausa(2500);
		nPage.asignaValor("//textarea", "Prueba Selenium");
		System.out.println("Asigna descripcion");

	}

}
