package tests;

import java.io.IOException;
import java.util.Date;

import org.testng.annotations.Test;

import pages.homePage;
import pages.navegacionPages;

public class Tagenda extends baseTest {

	//@Test
	public void agendaTest() throws IOException {

		homePage home = new homePage(driver);
		navegacionPages nPage = new navegacionPages(driver);
		Date dia = new Date();

		// Abrir Pagina principal
		home.launchHome();
		// Cierra ventana inicial
		nPage.closePopUpPrincipal();

		nPage.pausa(2500);

		// Abre Agenda Comercial
		nPage.click("//div[2]/div/div/a");
		nPage.pausa(5000);
		// Clientes con Tarjeta Vencida
		nPage.click("//a/div");
		nPage.closePopUp();
		nPage.pausa(5000);
		// Clientes con Tarjeta por Vencer
		nPage.click("//td[2]/a/div/span");
		nPage.closePopUp();
		nPage.pausa(5000);
		// Clientes sin TAZ
		nPage.click("//tr[3]/td[2]/a/div");
		nPage.closePopUp();

		// Control meses
		nPage.pausa(3000);
		nPage.click("//a/img");
		nPage.pausa(1000);
		nPage.click("//a/img");
		nPage.pausa(3000);
		nPage.click("//a[2]/img");
		nPage.pausa(1000);
		nPage.click("//a[2]/img");
		nPage.pausa(1000);
		nPage.click("//a[2]/img");
		nPage.pausa(3000);
		nPage.click("//div[2]/div/div/b");

		// Crear un evento
		nPage.pausa(1000);
		nPage.click("//div/img");
		nPage.pausa(1000);
		nPage.click("//input[@id='datepicker']");
		nPage.pausa(1000);
		nPage.click("//a[contains(.,'19')]");
		nPage.pausa(1000);
		nPage.asignaValor("//div[@id='contfan']/table[2]/tbody/tr/td/div/select", "08:00PM");
		nPage.pausa(1000);
		nPage.asignaValor("//div[@id='contfan']/table[3]/tbody/tr/td/div/select", "30min");
		nPage.pausa(1000);
		nPage.asignaValor("//select[@id='selectcampania']", "Término Préstamo ");
		nPage.pausa(1000);
		nPage.asignaValor("//textarea[@id='formAgendaDescripccionLargaCF']", "Prueba automatizada");
		nPage.pausa(1000);
		nPage.asignaValor("//input[@id='nuevoselectstates']", "01010100100078");
		nPage.pausa(1000);
		nPage.click("//strong[contains(.,'01010100100078')]");
		nPage.pausa(1000);
		nPage.click("//td[2]/table/tbody/tr/td/div/div");

		// Eliminar evento creado
		nPage.pausa(1000);
		nPage.click("//span[contains(.,'1 Agendados')]");
		nPage.pausa(1000);
		nPage.click("//td[9]/img");
	}

}
