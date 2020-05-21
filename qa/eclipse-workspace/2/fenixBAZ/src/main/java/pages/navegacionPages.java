package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.Select;
import org.testng.annotations.AfterClass;

public class navegacionPages extends basePage {

	public navegacionPages(WebDriver driver) {
		super(driver);
	}
	
	public void closePopUpPrincipal() {
		pausa(5000);
		driver.switchTo().frame(0);
		driver.findElement(By.id("fancybox-close")).click();
	}
	
	public void closePopUp() {
		pausa(5000);
		driver.findElement(By.id("fancybox-close")).click();
	}

	public void click(String xpath) {
		driver.findElement(By.xpath(xpath)).click();
		System.out.println("Fui a la clase seleccion");
	}
	
	public void enter(String xpath) {
		driver.findElement(By.xpath(xpath)).sendKeys(Keys.ENTER);
	}

	public void pausa(int valuems) {
		try {
			Thread.sleep(valuems);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	public void menu() {
		driver.findElement(By.xpath("//div/img")).click();
	}

	public void listaItem(String xpath, String opcion) {
		Select lineas = new Select(driver.findElement(By.xpath(xpath)));
		// lineas.selectByIndex(opcion);
		lineas.selectByVisibleText(opcion);
	}
	
	public void asignaValor(String xpath, String valor) {
		driver.findElement(By.xpath(xpath)).sendKeys(valor);
	}
	
	public void asignaDia(String xpath, String dia) {
		driver.findElement(By.xpath(xpath)).sendKeys(dia);
	}
	
	public void framePrincipal() {
		driver.switchTo().defaultContent();
	}
	
	public void seleccionaCliente() {
		driver.switchTo().frame(2);
		driver.findElement(By.xpath("//a")).click();
	}

}
