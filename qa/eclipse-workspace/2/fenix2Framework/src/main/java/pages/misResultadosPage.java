package pages;

import java.sql.Driver;
import java.util.ArrayList;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.Select;
import org.testng.annotations.Test;

import helpers.Hproperties;

public class misResultadosPage extends basePage {

	@FindBy(xpath = "//div/div/div[2]/div")
	WebElement btnDia;

	@FindBy(xpath = "//div/div/div[3]/div")
	WebElement btnSemana;

	private String url = Hproperties.strUrl;
	public ArrayList<String> paso = new ArrayList<>();
	public ArrayList<String> status = new ArrayList<>();

	public misResultadosPage(WebDriver driver) {
		super(driver);
	}

	public void clickSemana() {
		driver.findElement(By.xpath("//div/div/div[3]/div")).click();
	}

	public void clickDia() {
		driver.findElement(By.xpath("//div/div/div[2]/div")).click();
	}

	public void clickLineasObj() {
		int timeOutLines = 2000;
		try {
			Select lineas = new Select(driver.findElement(By.xpath("//select")));
			for (int i = 0; i == 7; i++) {
				lineas.selectByIndex(i);
				Thread.sleep(timeOutLines);
				/*
				 * } lineas.selectByIndex(1); Thread.sleep(timeOutLines);
				 * lineas.selectByIndex(2); Thread.sleep(timeOutLines); lineas.selectByIndex(3);
				 * Thread.sleep(timeOutLines); lineas.selectByIndex(4);
				 * Thread.sleep(timeOutLines); lineas.selectByIndex(5);
				 * Thread.sleep(timeOutLines); lineas.selectByIndex(6);
				 * Thread.sleep(timeOutLines); lineas.selectByIndex(7);
				 * Thread.sleep(timeOutLines);
				 */
			}
			lineas.selectByIndex(0);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	public void clickMisClientes() {
		int timeOutClientes = 1500;
		try {
			driver.findElement(By.xpath("//app-overview-with-order/div")).click();
			Thread.sleep(timeOutClientes);
			driver.findElement(By.xpath("//app-overview-without-order/div")).click();
			Thread.sleep(timeOutClientes);
			driver.findElement(By.xpath("//app-overview-pending-supply/div")).click();
			Thread.sleep(timeOutClientes);
			driver.findElement(By.xpath("//app-overview-applications/div")).click();
			Thread.sleep(timeOutClientes);
			driver.findElement(By.xpath("//app-overview-budgets/div")).click();
			Thread.sleep(timeOutClientes);
			driver.findElement(By.xpath("//app-overview-promotions/div")).click();
			Thread.sleep(timeOutClientes);
			driver.findElement(By.xpath("//app-overview-with-order/div")).click();
			Thread.sleep(timeOutClientes);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	public void clickBanner() throws InterruptedException {
		int timeOutBanner = 1000;
		int timeOutSemiBanner = 500;
		
		
		driver.findElement(By.xpath("//button[2]")).click();
		driver.wait(timeOutSemiBanner);
		driver.findElement(By.xpath("//button")).click();
		driver.findElement(By.xpath("//button")).click();
		driver.findElement(By.xpath("//button")).click();
		
		
		
		try {
			System.out.println("Entre al try.");
			driver.findElement(By.className(".owl-prev")).click();
			driver.findElement(By.cssSelector(".owl-prev")).click();
			
		} catch (Exception e) {
			System.out.println(e);
			System.out.println("Entre al catch.");
		}
	}
}
